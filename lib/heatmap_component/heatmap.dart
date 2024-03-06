import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype_app/heatmap_component/google_maps.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_app/heatmap_component/utils.dart';

class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heatmap'),
      ),
      body: Center(
          child: FutureBuilder<Set<Marker>>(
              future: _getMarkers(),
              builder:
                  (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
                if (snapshot.hasData) {
                  return MapSample(markers: snapshot.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }

  Future<Set<Marker>> _getMarkers() async {

      Uri url;
      if (const String.fromEnvironment("ENV") == "dev") {
        url = Uri.http(dotenv.get("API_URL"), "/markers");
    } else {
      url = Uri.https(const String.fromEnvironment("API_URL"),"/markers");
    }


    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        return MarkersParser.parseMarkers(response.body);
      } catch (e) {
        throw Exception('Failed to parse markers');
      }
    } else {
      throw Exception('Failed to load markers');
    }
  }
}
