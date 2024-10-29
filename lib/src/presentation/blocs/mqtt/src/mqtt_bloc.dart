import 'package:flutter_bloc/flutter_bloc.dart';
import 'mqtt_event.dart';
import 'mqtt_model.dart';
import 'mqtt_state.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  final MqttClient client;
  List<MqtMessage> receivedMessages = [];

  MqttBloc(this.client) : super(MqttInitial()) {
    on<SubscribeToTopic>((event, emit) async {
      try {
        client.subscribe(event.topic, MqttQos.atLeastOnce);
      } catch (e) {
        emit(MqttError('Failed to subscribe: ${e.toString()}'));
      }
    });

    on<PublishMessage>((event, emit) async {
      try {
        final builder = MqttClientPayloadBuilder();
        builder.addString(event.message);
        client.publishMessage(event.topic, MqttQos.atLeastOnce, builder.payload!);
      } catch (e) {
        emit(MqttError('Failed to publish: ${e.toString()}'));
      }
    });

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMessage = c[0].payload as MqttPublishMessage;
      final String payload = MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);
      receivedMessages.add(MqtMessage(c[0].topic, payload ));
      emit(MqttMessageReceived(List.from(receivedMessages))); // Emit the updated list of messages
    });
  }
}