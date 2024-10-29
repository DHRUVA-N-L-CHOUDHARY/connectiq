// lib/screens/dashboard_screen.dart
import 'package:connectiq/src/presentation/blocs/ble/ble_repository.dart';
import 'package:connectiq/src/presentation/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/src/auth_bloc.dart';
import '../../blocs/auth/src/auth_event.dart';
import '../../blocs/auth/src/auth_state.dart';
import '../../blocs/ble/src/ble_bloc.dart';
import '../../blocs/ble/src/ble_state.dart';
import '../available_ble_listing/available_ble_listing_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('ConnectIQ Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LogoutRequested());
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to ConnectIQ!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connected BLE Device Data',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        BlocBuilder<BleBloc, BleState>(
                          builder: (context, state) {
                            if (state is BleConnected) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Device Name: ${state.connectedDevice.name}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Data: <Data from BLE>',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              );
                            } else if (state is BleScanning) {
                              return Text('Scanning for devices...');
                            } else {
                              return Text('No devices connected.');
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => BleBloc(BleRepository()),
                                  child: BleDevicesScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text('View Devices'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Real-time MQTT Data',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        // BlocBuilder<MqttBloc, MqttState>(
                        //   builder: (context, state) {
                        //     if (state is MqttMessageReceived) {
                        //       return ListView.builder(
                        //         shrinkWrap: true,
                        //         itemCount: state.messages.length,
                        //         itemBuilder: (context, index) {
                        //           final message = state.messages[index];
                        //           return ListTile(
                        //             title: Text('Topic: ${message.topic}'),
                        //             subtitle:
                        //                 Text('Message: ${message.payload}'),
                        //           );
                        //         },
                        //       );
                        //     } else {
                        //       return Text('No MQTT messages received.');
                        //     }
                        //   },
                        // ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to MQTT control panel
                          },
                          child: Text('View MQTT Controls'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Activities',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        // Sample activities, replace with real data
                        Text('Connected to Device: Smart Light - 10:00 AM'),
                        Text('Received MQTT Message: Temperature - 24°C'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Additional Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to more settings or controls
                      },
                      child: Text('Settings'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Open other functionality like data logs, etc.
                      },
                      child: Text('Data Logs'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
