import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomSheetWrapper extends StatelessWidget {
  final double sheetCurrentSize;
  final void Function(double) onSizeChange;
  final LatLng? currentPosition;
  final String? address;

  const BottomSheetWrapper({
    super.key,
    required this.sheetCurrentSize,
    required this.onSizeChange,
    required this.currentPosition,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.16,
      minChildSize: 0.16,
      maxChildSize: 1.0,
      builder: (_, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            onSizeChange(notification.extent);
            return false;
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: currentPosition == null
                ? const Text("Getting location...")
                : ListView(
              controller: scrollController,
              padding: EdgeInsets.zero,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  "Your Current Location:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(address ?? "", style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }
}

