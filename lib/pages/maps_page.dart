import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/model/response_getstory_model.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key, required this.listStory}) : super(key: key);

  final List<ListStory> listStory;

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late List<ListStory> listStory = widget.listStory;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    setState(() {
      generateMarkers();
    });
    super.initState();
  }

  generateMarkers() {
    int count = 0;
    for (var story in listStory) {
      count += 1;
      final String markerIdVal = 'marker_id_$count';
      final MarkerId markerId = MarkerId(markerIdVal);

      final Marker marker = Marker(
          markerId: markerId,
          draggable: false,
          position: LatLng(
            story.lat!,
            story.lon!,
          ),
          infoWindow: InfoWindow(
            title: story.name.toString(),
            snippet: story.description.toString(),
          ),
          icon: markerIcon,
          onTap: () {
            print(story.name.toString());
            print(story.description.toString());
          });

      markers[markerId] = marker;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialLocation = LatLng(listStory[0].lat!, listStory[0].lon!);
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
        // markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  // Marker addMarker() {
  //   return Marker(
  //     markerId: const MarkerId("marker1"),
  //     position: const LatLng(-6.278426, 106.8292968),
  //     draggable: false,
  //     infoWindow: const InfoWindow(title: "Test", snippet: "Test Snippet"),
  //     onTap: () {
  //       // Go to StoryDetails
  //     },
  //     onDragEnd: (value) {
  //       // value is the new position
  //     },
  //     icon: markerIcon,
  //   );
  // }
}
