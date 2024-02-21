import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype_app/heatmap_component/google_maps.dart';

class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heatmap'),
      ),
      body: Center(
          child: MapSample(
            markers: {
              Marker(markerId: MarkerId("1"), position: LatLng(51.44723174143103, 5.488294511188016)),
            },
            polygons: {
              Polygon(
                polygonId: PolygonId("1"),
                points: [
                  LatLng(51.44723174143103, 5.498294511188016),
                  LatLng(51.45723174143103, 5.488294511128016),
                  LatLng(51.44723174143103, 5.488294511188016),
                ],
                strokeWidth: 2,
                strokeColor: Colors.red,
                fillColor: Colors.red.withOpacity(0.5),
              ),
            }
          ),
      ),
    );
  }
}
