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
    if (currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Dummy markers list
    final Set<Marker> markers = {
      // 🔴 Emergency markers
      Marker(
        markerId: const MarkerId('emergency1'),
        position: LatLng(
          currentPosition!.latitude + 0.001,
          currentPosition!.longitude + 0.001,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Emergency 1'),
      ),
      Marker(
        markerId: const MarkerId('emergency2'),
        position: LatLng(
          currentPosition!.latitude - 0.001,
          currentPosition!.longitude - 0.001,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Emergency 2'),
      ),

      // 🟡 Update markers
      Marker(
        markerId: const MarkerId('update1'),
        position: LatLng(
          currentPosition!.latitude + 0.002,
          currentPosition!.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: const InfoWindow(title: 'Update 1'),
      ),
      Marker(
        markerId: const MarkerId('update2'),
        position: LatLng(
          currentPosition!.latitude,
          currentPosition!.longitude + 0.002,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: const InfoWindow(title: 'Update 2'),
      ),
    };

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: currentPosition!, zoom: 15),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: onMapCreated,
      markers: markers,
    );
  }
}
