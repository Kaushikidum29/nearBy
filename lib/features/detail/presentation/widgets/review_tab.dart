import 'package:flutter/material.dart';
import 'package:near_by/features/detail/presentation/widgets/add_review_bottom_sheet.dart';
import 'package:near_by/features/detail/presentation/widgets/review_item.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({super.key});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Kaushiki Kumari',
      'rating': 5,
      'comment': 'Excellent service and well maintained facility!',
      'date': 'July 20, 2025',
    },
    {
      'name': 'Rahul Sharma',
      'rating': 4,
      'comment': 'Friendly staff and clean environment.',
      'date': 'July 18, 2025',
    },
  ];

  final Map<int, double> ratingBreakdown = {
    5: 0.9,
    4: 0.6,
    3: 0.4,
    2: 0.2,
    1: 0.1,
  };

  void _addReview(String name, int rating, String comment) {
    setState(() {
      reviews.insert(0, {
        'name': name,
        'rating': rating,
        'comment': comment,
        'date': 'Today',
      });
    });
  }

  void _openAddReviewSheet() {
    String name = '';
    int rating = 5;
    String comment = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Wrap(
          children: [
            const Text(
              "Add a Review",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Your Name'),
              onChanged: (val) => name = val,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: rating,
              items: [1, 2, 3, 4, 5]
                  .map(
                    (r) => DropdownMenuItem(value: r, child: Text("$r Stars")),
                  )
                  .toList(),
              onChanged: (val) => rating = val ?? 5,
              decoration: const InputDecoration(labelText: 'Rating'),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Comment'),
              maxLines: 3,
              onChanged: (val) => comment = val,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty && comment.isNotEmpty) {
                  _addReview(name, rating, comment);
                  Navigator.pop(context);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildRatingBar(int stars, double percent) {
    Color getColorByStars(int stars) {
      switch (stars) {
        case 5:
          return Colors.green;
        case 4:
          return Colors.lightGreen;
        case 3:
          return Colors.amber;
        case 2:
          return Colors.orange;
        default:
          return Colors.red;
      }
    }

    return Row(
      children: [
        Text('$stars ★', style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(width: 8),
        Expanded(
          child: LinearPercentIndicator(
            lineHeight: 8.0,
            percent: percent,
            progressColor: getColorByStars(stars),
            backgroundColor: Colors.grey.shade300,
            barRadius: const Radius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        Text('${(percent * 100).toInt()}%'),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rating Breakdown",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...ratingBreakdown.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: _buildRatingBar(entry.key, entry.value),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 30),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reviews",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    _openAddReviewSheet();
                  },
                  child: Text(
                    "Add review",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: List.generate(4, (_) => const ReviewItem())),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
