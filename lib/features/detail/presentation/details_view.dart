import 'package:flutter/material.dart';
import 'package:near_by/features/detail/presentation/widgets/add_review_bottom_sheet.dart';

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

  final List<String> tabs = [
    "Overview",
    "Directory",
    "Reviews",
    "Photos",
    "Updates",
    "About",
  ];

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
          _buildImageHeader(size),
          _buildHospitalInfo(),
          _buildExtraOptions(),
          const SizedBox(height: 5),
          _buildTabBar(),
          const Divider(height: 1),
          Expanded(
            child: _buildTabBarView(), // This makes it scrollable without overflow
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(Size size) {
    return Stack(
      children: [
        Container(
          height: size.height / 3,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://content.jdmagicbox.com/comp/def_content/hospitals/default-hospitals-2.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: 40,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              radius: 15,
              child: Icon(Icons.keyboard_backspace, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHospitalInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Farid Hospital",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text(
                "4.5 ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              ...List.generate(3, (_) => _starIcon(Icons.star)),
              _starIcon(Icons.star_half),
              _starIcon(Icons.star_border),
              const Text(
                " (9) ",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const Icon(Icons.circle, size: 3),
              const Text(
                " 11 min",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 3),
          const Text(
            "Open 24 hours",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Icon _starIcon(IconData icon) =>
      Icon(icon, size: 18, color: Colors.yellow.shade800);

  Widget _buildExtraOptions() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: actionItems.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = actionItems[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal.shade800 : Colors.teal.shade50,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Row(
                children: [
                  Icon(
                    item['icon'],
                    size: 18,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item['label'],
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabAlignment: TabAlignment.start,
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.black,
      tabs: tabs.map((title) => Tab(text: title)).toList(),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: List.generate(tabs.length, (index) {
        if (index == 0) return _buildOverviewTab();
        return _buildReviewsTab();
      }),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          const Text(
            "Add a highlight from a recent visit",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          _buildHighlightButton(),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Reviews",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => const AddReviewBottomSheet(),
                  );
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
          const SizedBox(height: 15),
          // ⛔ Was causing overflow because shrinkWrap + Column in scroll
          Column(
            children: List.generate(4, (index) => _reviewItem()),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightButton() {
    return Container(
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
    );
  }

  Widget _reviewItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom:16.0),
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
                      const Text(
                        "Mukund jee Sharan",
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: const [
                          Text(
                            "Local Guide ",
                            style: TextStyle(fontSize: 12, color: Colors.black45),
                          ),
                          Icon(Icons.circle, size: 3),
                          Text(
                            " 62 reviews",
                            style: TextStyle(fontSize: 12, color: Colors.black45),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 20),
                onSelected: (value) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("$value clicked")));
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
              const Text(
                " 4 years ago",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
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

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(15.0),
      itemCount: 3,
      itemBuilder: (_, index) => _buildReviewTile(index),
    );
  }


  Widget _buildReviewTile(int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(
        "User ${index + 1}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text("Great service and friendly staff!"),
    );
  }
}
