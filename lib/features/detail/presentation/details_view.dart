import 'package:flutter/material.dart';
import 'package:near_by/features/detail/presentation/widgets/about_tab.dart';
import 'package:near_by/features/detail/presentation/widgets/extra_options.dart'
    show ExtraOptions;
import 'package:near_by/features/detail/presentation/widgets/hospital_info.dart';
import 'package:near_by/features/detail/presentation/widgets/image_header.dart';
import 'package:near_by/features/detail/presentation/widgets/overview_tab.dart';
import 'package:near_by/features/detail/presentation/widgets/photos_tab.dart';
import 'package:near_by/features/detail/presentation/widgets/review_tab.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> actionItems = [
    {'icon': Icons.directions, 'label': 'Directions'},
    {'icon': Icons.start, 'label': 'Start'},
    {'icon': Icons.bookmark_border, 'label': 'Save'},
    {'icon': Icons.share, 'label': 'Share'},
    {'icon': Icons.add, 'label': 'Post'},
  ];

  final List<String> tabs = ["Overview", "About", "Photos", "Reviews"];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ImageHeader(size: size),
          const HospitalInfo(),
          ExtraOptions(
            items: actionItems,
            selectedIndex: selectedIndex,
            onTap: (index) => setState(() => selectedIndex = index),
          ),
          const SizedBox(height: 5),
          TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: tabs.map((title) => Tab(text: title)).toList(),
          ),
          const Divider(height: 1),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(tabs.length, (index) {
                if (index == 0) return const OverviewTab();
                if (index == 1) return const AboutTab();
                if (index == 2) return const PhotosTab();
                return const ReviewTab();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
