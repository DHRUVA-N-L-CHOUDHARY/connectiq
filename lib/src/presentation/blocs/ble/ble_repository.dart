// lib/repositories/ble_repository.dart
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleRepository {

  /// Starts scanning for BLE devices.
  Future<void> startScan() async {
    // Start scanning for devices for 5 seconds.
    await FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
  }

  /// Stops scanning for BLE devices.
  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  /// Returns a stream of scan results containing BLE devices found during the scan.
  Stream<List<ScanResult>> get scanResults async* {
    await for (var results in FlutterBluePlus.scanResults) {
      yield results;
    }
  }

  /// Returns a list of connected devices that have already been bonded/connected.
  Future<List<BluetoothDevice>> getConnectedDevices() async {
    return await FlutterBluePlus.connectedDevices;
  }

  /// Connects to a given device.
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
  }

  /// Disconnects from a given device.
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
  }
}
