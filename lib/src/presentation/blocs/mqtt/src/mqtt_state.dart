import 'mqtt_model.dart';

abstract class MqttState {}

class MqttInitial extends MqttState {}

class MqttMessageReceived extends MqttState {
  final List<MqtMessage> messages;
  MqttMessageReceived(this.messages);
}

class MqttError extends MqttState {
  final String errorMessage;
  MqttError(this.errorMessage);
}
