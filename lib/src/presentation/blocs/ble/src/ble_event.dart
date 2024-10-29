// lib/blocs/ble_event.dart
abstract class BleEvent {}

class ScanStarted extends BleEvent {}
class DeviceSelected extends BleEvent {
  final String deviceId;
  DeviceSelected(this.deviceId);
}
class StopScan extends BleEvent {}
