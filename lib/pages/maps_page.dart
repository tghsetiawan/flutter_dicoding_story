import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../routes/router.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  LatLng initialLocation = const LatLng(-6.278426, 106.8292968);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  // ToDo: add custom marker

  @override
  void initState() {
    // addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/Location_marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: const LatLng(-6.278426, 106.8292968),
            draggable: true,
            infoWindow:
                const InfoWindow(title: "Test", snippet: "Test Snippet"),
            onTap: () {
              // Go to StoryDetails
            },
            onDragEnd: (value) {
              // value is the new position
            },
            icon: markerIcon,
          ),
          // Marker(
          //   markerId: const MarkerId("marker2"),
          //   position: const LatLng(37.415768808487435, -122.08440050482749),
          // ),
        },
      ),
    );
  }
}
