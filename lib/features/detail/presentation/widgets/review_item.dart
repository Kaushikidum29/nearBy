
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key});

  Icon _starIcon(IconData icon) =>
      Icon(icon, size: 18, color: Colors.yellow.shade800);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 20),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Mukund jee Sharan", style: TextStyle(fontSize: 15)),
                      Row(
                        children: const [
                          Text("Local Guide ", style: TextStyle(fontSize: 12, color: Colors.black45)),
                          Icon(Icons.circle, size: 3),
                          Text(" 62 reviews", style: TextStyle(fontSize: 12, color: Colors.black45)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 20),
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$value clicked")),
                  );
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'share', child: Text('Share')),
                  PopupMenuItem(value: 'report', child: Text('Report Review')),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ...List.generate(3, (_) => _starIcon(Icons.star)),
              _starIcon(Icons.star_half),
              _starIcon(Icons.star_border),
              const Text(" 4 years ago", style: TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 5),
          const Text("You will get best service here, 24x7 service available."),
          const SizedBox(height: 15),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.favorite, color: Colors.red, size: 20),
              SizedBox(width: 5),
              Text("15"),
            ],
          ),
        ],
      ),
    );
  }
}
