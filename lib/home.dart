import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app/DeviceDataSingleton.dart';
import 'package:prototype_app/DeviceSelector.dart';
import 'package:prototype_app/heatmap_component/heatmap.dart';
import 'package:prototype_app/information.dart';
import 'package:prototype_app/report.dart';

import 'BluetoothHandler.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final BlueToothHandler guardHandler = BlueToothHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpikeGuard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) => infoModal(context),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmergencyInformationPage()),
                        );
                      },
                      child: Text("Set up quick report"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                      ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HeatmapPage()),
                      );
                    },
                    child: Text("Heatmap"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child:
              // Text("Battery ${DeviceDataSingleton.getInstance().batteryStatus}%"),
              // Text("Spiking ${DeviceDataSingleton.getInstance().isSpiking}"),
              DeviceStatus(guardHandler: guardHandler),
          ),
        ],
      ),
    );
  }
}
