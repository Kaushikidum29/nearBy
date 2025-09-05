import 'package:flutter/material.dart';

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
      ],
    );
  }
}
