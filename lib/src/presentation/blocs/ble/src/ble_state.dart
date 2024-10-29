// lib/blocs/ble_state.dart
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BleState {}

class BleInitial extends BleState {}
class BleScanning extends BleState {}
class BleDevicesFound extends BleState {
  final List<BluetoothDevice> devices;
  BleDevicesFound(this.devices);
}
class BleConnected extends BleState {
  final BluetoothDevice connectedDevice;
  BleConnected(this.connectedDevice);
}
class BleError extends BleState {
  final String message;
  BleError(this.message);
}
