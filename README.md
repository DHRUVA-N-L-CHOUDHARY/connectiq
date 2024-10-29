# ConnectIQ Smart Home Dashboard

ConnectIQ is a smart home dashboard application developed using Flutter. The application integrates Bluetooth Low Energy (BLE) and MQTT protocols to provide real-time control and monitoring of smart devices. The app includes features such as Firebase Authentication, BLE device scanning, MQTT subscription, and message publishing.

## Features

- **Firebase Authentication**: Users can sign up, log in, and log out securely using Firebase Authentication.
- **BLE Integration**: Scan for BLE devices, connect to them, and display their real-time data.
- **MQTT Integration**: Connect to an MQTT broker, subscribe to topics, and publish messages to control smart devices.
- **State Management**: The app uses the BLoC (Business Logic Component) pattern for efficient state management.
- **Real-time Control**: Users can subscribe to MQTT topics, publish messages, and monitor device data in real-time.

## Screens

1. **Login Screen**: Users can log in or sign up with their credentials using Firebase Authentication.
2. **Dashboard Screen**: Provides an overview of connected BLE devices, MQTT messages, and allows navigation to other controls.
3. **Available BLE Devices Screen**: Lists available BLE devices, allowing users to connect to them and view data.
4. **MQTT Controls Screen**: Allows users to subscribe to MQTT topics and publish messages, displaying received messages in real-time.

## File Structure

- **lib/screens**: Contains UI screens such as `DashboardScreen`, `MqttControlsScreen`, and BLE device listing screens.
- **lib/blocs/auth/src**: Contains BLoC classes for managing authentication states.
- **lib/blocs/ble/src**: Contains BLoC classes for managing BLE device states.
- **lib/blocs/mqtt/src**: Contains BLoC classes (`mqtt_bloc.dart`, `mqtt_event.dart`, `mqtt_state.dart`) for managing MQTT subscription and publishing.
- **lib/blocs/mqtt/src/mqtt_message.dart**: Custom data model for handling MQTT messages.

## How to Run the Project

### Prerequisites

- Flutter SDK (v2.0 or later)
- Firebase Project setup with Authentication enabled
- MQTT Broker (e.g., HiveMQ, Mosquitto)

### Installation Steps

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd connectiq
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Add your Firebase configuration files (`google-services.json` for Android and `GoogleService-Info.plist` for iOS).

4. **Run the Application**:
   ```bash
   flutter run
   ```

## Usage

- **Login**: Open the app and sign up or log in using Firebase Authentication.
- **Dashboard**: View connected BLE devices and real-time MQTT messages.
- **BLE Devices**: Scan and connect to available BLE devices.
- **MQTT Controls**: Subscribe to MQTT topics and publish messages to control devices.

## MQTT Configuration

- The MQTT client connects to `broker.hivemq.com` as a sample broker.
- Update the broker details in `MqttBloc` in `lib/blocs/mqtt/src/mqtt_bloc.dart` if using a different broker.

## BLoC State Management

The BLoC pattern is used for managing state across different parts of the app:

- **AuthBloc**: Handles user authentication, including login, signup, and logout.
- **BleBloc**: Manages BLE device scanning, connection, and disconnection.
- **MqttBloc**: Handles MQTT operations, including subscribing to topics and publishing messages.

## Dependencies

- **flutter_bloc**: For state management using the BLoC pattern.
- **firebase_auth**: For user authentication using Firebase.
- **flutter_blue_plus**: For BLE integration.
- **mqtt_client**: For MQTT communication.
- **permission_handler**: For managing permissions on Android and iOS.

## Future Enhancements

- **Device Control Enhancements**: Add more granular controls for BLE devices.
- **Improved UI/UX**: Enhance the user interface for a better user experience.
- **Notifications**: Add push notifications for critical MQTT messages.

## License

This project is licensed under the MIT License.

## Contact

For any inquiries or issues, please contact the project maintainer at [maintainer@example.com].

