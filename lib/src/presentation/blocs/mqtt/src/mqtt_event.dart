// lib/blocs/mqtt/src/mqtt_event.dart
abstract class MqttEvent {}

class SubscribeToTopic extends MqttEvent {
  final String topic;
  SubscribeToTopic(this.topic);
}

class PublishMessage extends MqttEvent {
  final String topic;
  final String message;
  PublishMessage(this.topic, this.message);
}
