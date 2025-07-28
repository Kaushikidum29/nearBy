import 'package:flutter/material.dart';
import 'package:near_by/features/detail/presentation/details_view.dart';
import 'package:near_by/features/detail/presentation/widgets/add_review_bottom_sheet.dart';
import 'package:near_by/features/detail/presentation/widgets/review_item.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  Icon _starIcon(IconData icon) =>
      Icon(icon, size: 18, color: Colors.yellow.shade800);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.teal),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "C6CX+56Q, Dhawa-Buxar RD, Kesath, Dasiyawan, Bihar 802125",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 8),
          const Text("Add a highlight from a recent visit", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          Container(
            height: 40,
            width: 210,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.linked_camera_outlined, size: 18, color: Colors.black87),
                SizedBox(width: 6),
                Text("Post a photo update", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Reviews", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => const AddReviewBottomSheet(),
                  );
                },
                child: Text("Add review", style: TextStyle(fontSize: 14, color: Colors.teal.shade800, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: List.generate(4, (_) => const ReviewItem()),
          ),
        ],
      ),
    );
  }
}
