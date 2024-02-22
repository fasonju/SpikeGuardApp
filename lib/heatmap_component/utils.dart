import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersParser {
  /// Parses the data from the server into a set of markers.
  /// ```
  ///  data is a string in the format:
  ///  {"markers": [{"id": 1, "latitude": 1.2, "longitude": 1.2}]"}
  ///  ```
  static Set<Marker> parseMarkers(String data) {
    dynamic object = json.decode(data);
    Set<Marker> markers = {};
    for (var marker in object['markers']) {
      markers.add(Marker(
        markerId: MarkerId(marker['id'].toString()),
        position: LatLng(marker['latitude'].toDouble(), marker['longitude'].toDouble()),
      ));
    }
    return markers;

  }
}

