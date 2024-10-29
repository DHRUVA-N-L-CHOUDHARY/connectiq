import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../ble_repository.dart';
import 'ble_event.dart';
import 'ble_state.dart';

class BleBloc extends Bloc<BleEvent, BleState> {
  final BleRepository bleRepository;

  BleBloc(this.bleRepository) : super(BleInitial()) {
    on<ScanStarted>((event, emit) async {
      emit(BleScanning());
      try {
        await bleRepository.startScan();

        // Listen to the scan results stream and emit states asynchronously.
        await emit.forEach(
          bleRepository.scanResults,
          onData: (results) {
            List<BluetoothDevice> devices = results.map((result) => result.device).toList();
            return BleDevicesFound(devices);
          },
          onError: (error, stackTrace) => BleError('Failed to start scan: ${error.toString()}'),
        );
      } catch (e) {
        emit(BleError('Failed to start scan: ${e.toString()}'));
      }
    });

    on<StopScan>((event, emit) async {
      await bleRepository.stopScan();
      emit(BleInitial());
    });

    on<DeviceSelected>((event, emit) async {
      try {
        // Await to get the list of currently connected devices.
        List<BluetoothDevice> connectedDevices = await bleRepository.getConnectedDevices();

        // Find the device matching the given deviceId.
        BluetoothDevice? selectedDevice;
        for (var device in connectedDevices) {
          if (device.id.id == event.deviceId) {
            selectedDevice = device;
            break;
          }
        }

        if (selectedDevice != null) {
          emit(BleConnected(selectedDevice));
        } else {
          emit(BleError('Device not found'));
        }
      } catch (e) {
        emit(BleError('Failed to connect to the device: ${e.toString()}'));
      }
    });
  }
}
