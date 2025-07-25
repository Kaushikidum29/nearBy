import 'package:flutter/material.dart';

class FloatingActionButtons extends StatelessWidget {
  final callBack;
  const FloatingActionButtons({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.cyan.shade800,
          heroTag: 'directionBtn',
          onPressed: () {
            // Direction action
          },
          tooltip: 'Direction',
          child: const Icon(Icons.directions, color: Colors.white),
        ),
        const SizedBox(height: 15.0,),
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
      ],
    );
  }
}
