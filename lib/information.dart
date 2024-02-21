import 'package:flutter/material.dart';

AlertDialog infoModal(BuildContext context) {
  return AlertDialog(
    title: const Text('Info'),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(onPressed: null, child: Text("How to use SpikeGuard")),
        ElevatedButton(onPressed: null, child: Text("Information about spiking")),
      ],

    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('OK'),
      ),
    ],
  );
}