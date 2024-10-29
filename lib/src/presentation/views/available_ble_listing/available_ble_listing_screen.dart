// lib/screens/ble_devices_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/ble/src/ble_bloc.dart';
import '../../blocs/ble/src/ble_event.dart';
import '../../blocs/ble/src/ble_state.dart';


class BleDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available BLE Devices'),
      ),
      body: BlocBuilder<BleBloc, BleState>(
        builder: (context, state) {
          if (state is BleScanning) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BleDevicesFound) {
            return ListView.builder(
              itemCount: state.devices.length,
              itemBuilder: (context, index) {
                final device = state.devices[index];
                return ListTile(
                  title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
                  subtitle: Text(device.id.id),
                  onTap: () {
                    BlocProvider.of<BleBloc>(context).add(DeviceSelected(device.id.id));
                  },
                );
              },
            );
          } else if (state is BleError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<BleBloc>(context).add(ScanStarted());
                },
                child: Text('Start Scan'),
              ),
            );
          }
        },
      ),
    );
  }
}
