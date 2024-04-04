import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

AlertDialog infoModal(BuildContext context) {
  final Uri url = Uri.parse(
      'https://www.police.uk/advice/advice-and-information/spiking/spiking/');
  return AlertDialog(
    title: const Text('Info'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            onPressed: () => _showHowToUse(context),
            child: Text("How to use SpikeGuard")),
         ElevatedButton(
            onPressed: () => _showSpikingInfo(context), child: Text("Information about spiking")),
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

_showSpikingInfo(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Spiking Information'),
          content: const SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text("""
        Rohypnol (flunitrazepam): Also known as "roofies," Rohypnol is a potent benzodiazepine that can cause sedation, amnesia, muscle relaxation, and a loss of inhibitions.

GHB (gamma-hydroxybutyric acid): GHB is a central nervous system depressant that can induce euphoria, relaxation, and amnesia. It's often colorless and odorless, making it easy to slip into drinks unnoticed.

Ketamine: Although primarily used as an anesthetic, ketamine can also be used as a date rape drug due to its sedative effects, causing disassociation, confusion, and memory loss.
        """, style: TextStyle(fontSize: 20),),
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
      });
}

_showHowToUse(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How to use SpikeGuard'),
          content: const Text("""
          "Welcome to SpikeGuard! Our little gadget is your wingman for safer nights out. Here's the lowdown: Press the button on the bottom right to pair with the app. In the emergency contact page you can set up your emergency contact in case things go south. Drop it in your drink, and if it detects any funny business, both your phone and the device will vibe like crazy. Just remember, it's not foolproof, so stay vigilant and look out for each other. Cheers to safer sipping!"
          """, style: TextStyle(fontSize: 20),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}
