import 'package:flutter/material.dart';
import 'package:near_by/features/detail/presentation/details_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Auto focus text field on page load, but do NOT close keyboard on typing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    // Just update UI on text changes, no keyboard dismiss here
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Close keyboard only on done (submit)
  void _onSearchSubmitted(String value) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final inputText = _controller.text.trim().toLowerCase();

    final bool isEmpty = inputText.isEmpty;
    final bool showCategory = inputText.contains("cat");
    final bool showSearchResults = inputText.isNotEmpty && !showCategory;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _searchBar(),
              const SizedBox(height: 16),
              if (isEmpty) _recentSearches(),

              if (showCategory) _searchCategory(),

              if (showSearchResults) _searchResults(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(left: 12),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(35.0),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.keyboard_backspace, size: 25),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onSubmitted: _onSearchSubmitted,
              decoration: const InputDecoration(
                hintText: 'Search here...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _recentSearches() {
    return _sectionWrapper(
      title: "Recent",
      icon: Icons.info_outline,
      children: List.generate(
        6,
        (_) => _listTile(
          "DLF CORPORATE GREENS",
          "Southern Peripheral Rd, Sector 74A, Gurugram, Haryana 122004",
          leadingIcon: Icons.access_time_outlined,
        ),
      ),
    );
  }

  Widget _searchResults() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => DetailsView()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Farid Hospital",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "5.0",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.yellow.shade800,
                            ),
                            Text(
                              " (9) ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.circle, size: 3),
                        Text(
                          " General hospital",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Open 24 hours ",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Icon(Icons.circle, size: 3),
                        Text(
                          " Closes 10:10 pm ",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        Icon(Icons.circle, size: 3),
                        Text(
                          " 3.0 km",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 130,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://content.jdmagicbox.com/comp/def_content/hospitals/default-hospitals-2.jpg",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 15,
                          color: Colors.blue.shade300,
                        ),

                        Text(
                          "  Service was very good here.",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              color: Colors.lightBlue.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.directions,
                                      size: 15,
                                      color: Colors.black87,
                                    ),

                                    Text(
                                      "  Directions",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 0,
                              color: Colors.lightBlue.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 15,
                                      color: Colors.black87,
                                    ),

                                    Text(
                                      "  Share",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 0,
                              color: Colors.lightBlue.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.bookmark_border,
                                      size: 15,
                                      color: Colors.black87,
                                    ),

                                    Text(
                                      "  Save",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _searchCategory() {
    return _sectionWrapper(
      title: "Categories",
      icon: Icons.category,
      children: List.generate(
        6,
        (_) => _listTile(
          "Category Name",
          "Category description",
          leadingIcon: Icons.category,
        ),
      ),
    );
  }

  Widget _listTile(
    String title,
    String subtitle, {
    required IconData leadingIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            child: Icon(leadingIcon, color: Colors.black),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_upward_rounded, size: 20),
        ],
      ),
    );
  }

  Widget _sectionWrapper({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.14),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
