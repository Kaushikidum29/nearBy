import 'package:flutter/material.dart';
import 'package:near_by/features/activity/presentation/widgets/found_items_view.dart';
import 'package:near_by/features/activity/presentation/widgets/lost_items_view.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0, // removes shadow
          scrolledUnderElevation: 0, // removes scroll glow/shadow (Flutter 3.7+)
          shadowColor: Colors.transparent, // ensures no border line
          backgroundColor: Colors.white,
          title: const Text(
            "Activity",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.cyan.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black87,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                tabAlignment: TabAlignment.fill,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: "Lost"),
                  Tab(text: "Found"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            LostItemsView(),
            FoundItemsView(),
          ],
        ),
      ),
    );
  }
}
