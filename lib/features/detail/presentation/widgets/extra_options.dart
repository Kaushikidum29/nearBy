
import 'package:flutter/material.dart';

class ExtraOptions extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int selectedIndex;
  final Function(int) onTap;

  const ExtraOptions({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal.shade800 : Colors.teal.shade50,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Row(
                children: [
                  Icon(item['icon'], size: 18, color: isSelected ? Colors.white : Colors.black87),
                  const SizedBox(width: 6),
                  Text(item['label'], style: TextStyle(fontSize: 14, color: isSelected ? Colors.white : Colors.black87)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
