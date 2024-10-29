import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/mqtt/src/mqtt_bloc.dart';
import '../../blocs/mqtt/src/mqtt_event.dart';
import '../../blocs/mqtt/src/mqtt_state.dart';


class MqttControlsScreen extends StatelessWidget {
  final TextEditingController topicController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MQTT Controls'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subscribe to Topic Section
            Text(
              'Subscribe to a Topic',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: topicController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Topic',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (topicController.text.isNotEmpty) {
                  BlocProvider.of<MqttBloc>(context).add(SubscribeToTopic(topicController.text));
                }
              },
              child: Text('Subscribe'),
            ),
            SizedBox(height: 20),

            // Publish a Message Section
            Text(
              'Publish a Message',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Message',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (topicController.text.isNotEmpty && messageController.text.isNotEmpty) {
                  BlocProvider.of<MqttBloc>(context).add(PublishMessage(topicController.text, messageController.text));
                }
              },
              child: Text('Publish'),
            ),
            SizedBox(height: 20),

            // Display MQTT Messages
            Text(
              'MQTT Messages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<MqttBloc, MqttState>(
                builder: (context, state) {
                  if (state is MqttMessageReceived) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ListTile(
                          title: Text('Topic: ${message.topic}'),
                          subtitle: Text('Message: ${message.payload}'),
                        );
                      },
                    );
                  } else if (state is MqttError) {
                    return Text('Error: ${state.errorMessage}');
                  } else {
                    return Text('No messages received.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}