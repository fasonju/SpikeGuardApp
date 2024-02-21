import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app/heatmap_component/google_maps.dart';

class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heatmap'),
      ),
      body: const Center(
          child: MapSample(),
      ),
    );
  }
}
