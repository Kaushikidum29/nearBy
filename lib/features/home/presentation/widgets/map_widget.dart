
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final LatLng? currentPosition;
  final Function(GoogleMapController) onMapCreated;

  const MapWidget({
    super.key,
    required this.currentPosition,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return currentPosition == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
      initialCameraPosition: CameraPosition(
        target: currentPosition!,
        zoom: 15,
      ),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: onMapCreated,
    );
  }
}

