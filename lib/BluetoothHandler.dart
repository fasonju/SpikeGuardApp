import 'dart:async';

import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prototype_app/DeviceDataSingleton.dart';
import 'package:vibration/vibration.dart';

class BlueToothHandler {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  Stream<DiscoveredDevice> deviceStream = Stream.empty();
  StreamSubscription<ConnectionStateUpdate>? connection;
  final serviceId = Uuid.parse("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
  final batteryCharacteristicId =
      Uuid.parse("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");
  Stream<List<int>> batteryStatusStream = Stream.empty();
  int batteryStatus = 0;

  void askPermissions() async {
    await Permission.location.request();
    await Permission.bluetoothScan.request();
  }

  void scanForDevices() {
    print("scanning");
    deviceStream = flutterReactiveBle.scanForDevices(withServices: []);
  }

  void connectToDevice(DiscoveredDevice device) async {
    FlutterIsolate.killAll();
    connection?.cancel();
    if (device.connectable != Connectable.available) {
      throw Exception("Device is not connectable");
    }

    handleDeviceDisconnection(device);

    await Future.delayed(const Duration(seconds: 3));
    await flutterReactiveBle.discoverAllServices(device.id);
    List<Service> services =
        await flutterReactiveBle.getDiscoveredServices(device.id);
    subscribeCharacteristics(services);
    handleCharacteristics(batteryStatusStream);
  }

  void subscribeCharacteristics(List<Service> services) {
    for (Service service in services) {
      print(service);
      if (serviceId == service.id) {
        for (Characteristic characteristic in service.characteristics) {
          subscribeIfUsedCharacteristic(characteristic);
        }
      }
    }
  }

  void subscribeIfUsedCharacteristic(Characteristic characteristic) {
    if (characteristic.id == batteryCharacteristicId) {
      batteryStatusStream = characteristic.subscribe();
    }
  }

  void handleDeviceDisconnection(DiscoveredDevice device) {
    Stream<ConnectionStateUpdate> connectionStream;
    connectionStream = flutterReactiveBle.connectToDevice(id: device.id);
    connection = connectionStream.listen((event) {
      if (event.connectionState == DeviceConnectionState.disconnecting ||
          event.connectionState == DeviceConnectionState.disconnected) {
        connection?.cancel();
      }
    });
  }
}

void handleCharacteristics(Stream<List<int>> batteryStatusStream) {
  print("handling characteristics");
  batteryStatusStream.listen((event) {
    print(event);
    String converted = String.fromCharCodes(event);
    List<String> values = converted.split(',');
    print("values");
    print(values);
    DeviceDataSingleton.getInstance().batteryStatus = int.parse(values[0]);
    print(DeviceDataSingleton.getInstance().isSpiking);
    if (DeviceDataSingleton.getInstance().isSpiking) {
          Vibration.vibrate(duration: 1000, amplitude: 255);
        }
      });
}
