import 'dart:async';

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
    late StreamSubscription<bool> spikingStream;
    spikingStream = DeviceDataSingleton.getInstance().isSpikingStream.stream.listen((isSpiking) {
      checkSpiking(isSpiking, spikingStream, context);
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DeviceDataSingleton.getInstance().isSpikingStream = StreamController<bool>.broadcast();
          DeviceDataSingleton.getInstance().batteryStatusStream = StreamController<int>.broadcast();
          DeviceDataSingleton.getInstance().faultyDevice = false;
          spikingStream = DeviceDataSingleton.getInstance().isSpikingStream.stream.listen((isSpiking) {
            checkSpiking(isSpiking, spikingStream, context);
          });
        },
        child: const Icon(Icons.reset_tv),
      ),
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
          StreamBuilder(stream: DeviceDataSingleton.getInstance().batteryStatusStream.stream, builder:
            (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return Text("Battery ${snapshot.data}%");
              } else {
                return const Text("Device not yet connected");
              }
            }
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

void checkSpiking(bool isSpiking, StreamSubscription<bool> spikingStream, BuildContext context) {
  if (isSpiking) {
    spikingStream.pause();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('Spiking detected'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print("Reporting");
            },
            child: const Text('Report'),
          ),
          TextButton(
            onPressed: () {
              DeviceDataSingleton.getInstance().faultyDevice = true;
              Navigator.of(context).pop();
            },
            child: const Text('False alarm'),
          ),
        ],
      ),
    );
  }

}
