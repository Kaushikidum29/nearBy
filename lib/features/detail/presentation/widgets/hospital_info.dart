import 'package:flutter/material.dart';

class HospitalInfo extends StatelessWidget {
  const HospitalInfo({super.key});

  Icon _starIcon(IconData icon) =>
      Icon(icon, size: 18, color: Colors.yellow.shade800);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Farid Hospital", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text("4.5 ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ...List.generate(3, (_) => _starIcon(Icons.star)),
              _starIcon(Icons.star_half),
              _starIcon(Icons.star_border),
              const Text(" (9) ", style: TextStyle(fontSize: 16, color: Colors.black54)),
              const Icon(Icons.circle, size: 3),
              const Text(" 11 min", style: TextStyle(fontSize: 16, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 3),
          const Text("Open 24 hours", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
