import 'package:flutter/material.dart';

import '../../../new_place/presentation/add_new_place_page.dart' show AddNewPlacePage;

class FloatingActionButtons extends StatelessWidget {
  final callBack;
  const FloatingActionButtons({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Positioned(
          bottom: 120, // wherever you want
          right: 16,
          child: FloatingActionButton(
            onPressed: () async {
              callBack();
            },
            child: Icon(Icons.my_location),
          ),
        ),
        const SizedBox(height: 15.0),
        FloatingActionButton.extended(
          backgroundColor: Colors.cyan.shade800,
          heroTag: 'directionBtn',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddNewPlacePage()),
            );
          },
          tooltip: 'Add New Place',
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            "Add New Place",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
