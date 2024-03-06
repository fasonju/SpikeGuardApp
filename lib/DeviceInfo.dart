import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceStatus extends StatefulWidget {
  const DeviceStatus({super.key});


  @override
  State<DeviceStatus> createState() => _DeviceStatusState();
}

class _DeviceStatusState extends State<DeviceStatus> {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  late Stream<DiscoveredDevice> devices;
  @override
  Widget build(BuildContext context) {
    Future<void> askPermissions() async {
      await Permission.location.request();
      await Permission.bluetoothScan.request();
    }
    askPermissions();
    devices = flutterReactiveBle.scanForDevices(withServices: [Uuid.parse("6E400001-B5A3-F393-E0A9-E50E24DCCA9E")]);


    return StreamBuilder<DiscoveredDevice>(
      stream: devices,
      builder: (BuildContext context, AsyncSnapshot<DiscoveredDevice> snapshot) {
        if (snapshot.hasData) {
          return Text('Discovered device: ${snapshot.data}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );


  }

}
