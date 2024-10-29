import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'src/presentation/blocs/auth/auth_repository.dart';
import 'src/presentation/blocs/auth/src/auth_bloc.dart';
import 'src/presentation/blocs/auth/src/auth_event.dart';
import 'src/presentation/blocs/ble/ble_repository.dart';
import 'src/presentation/blocs/ble/src/ble_bloc.dart';
import 'src/presentation/blocs/mqtt/src/mqtt_bloc.dart';
import 'src/presentation/views/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository())
            ..add(AuthCheckRequested()), // Injecting AuthBloc
        ),
        BlocProvider(
          create: (context) => BleBloc(BleRepository()), // Add BLE Bloc to MultiBlocProvider
        ),
          BlocProvider<MqttBloc>(
          create: (context) => MqttBloc(MqttClient('broker.hivemq.com', 'client-id')),
        ),
      ],
      child: MaterialApp(
        title: 'ConnectIQ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(), // Start with Login Screen
      ),
    );
  }
}
