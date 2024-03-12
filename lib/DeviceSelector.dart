import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prototype_app/BluetoothHandler.dart';

class DeviceStatus extends StatefulWidget {
  DeviceStatus({super.key, required this.guardHandler});


  @override
  State<DeviceStatus> createState() => _DeviceStatusState();
  final BlueToothHandler guardHandler;

}

class _DeviceStatusState extends State<DeviceStatus> {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> discoveredDevices = [];

  @override
  Widget build(BuildContext context) {
    widget.guardHandler.askPermissions();

    widget.guardHandler.scanForDevices();

    return DeviceSelector(widget.guardHandler);
  }

  Widget DeviceSelector(BlueToothHandler guardHandler) {
    return StreamBuilder(stream: guardHandler.deviceStream,
        builder: (BuildContext context,
            AsyncSnapshot<DiscoveredDevice> snapshot) {
          if (snapshot.hasData) {
            DiscoveredDevice newDevice = snapshot.data!;

            addIfNewDevice(newDevice);

            return ListView.builder(
                itemCount: discoveredDevices.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(discoveredDevices[index].name == "" ?
                    "Unknown" :
                    discoveredDevices[index].name),
                    subtitle: Text(discoveredDevices[index].id),
                    onTap: () {
                      try {
                        guardHandler.connectToDevice(
                            discoveredDevices[index]);
                      } catch (e) {
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(e.toString()),
                          );
                        });
                      }
                    },
                    dense: true,
                  );
                }
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void addIfNewDevice(DiscoveredDevice newDevice) {
    bool unique = true;
    for (DiscoveredDevice existingDevice in discoveredDevices) {
      if (existingDevice.id == newDevice.id) {
        unique = false;
        break;
      }
    }
    if (unique && newDevice.name == "SPIKEGUARD") {
      discoveredDevices.add(newDevice);
    }
  }
}


