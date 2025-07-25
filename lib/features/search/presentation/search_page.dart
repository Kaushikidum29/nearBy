import 'package:flutter/material.dart';

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
              Container(
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
              ),
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
    return _sectionWrapper(
      title: "Top Results",
      icon: Icons.location_on_outlined,
      children: List.generate(
        6,
            (_) => _listTile(
          "Verrieres",
          "France",
          leadingIcon: Icons.location_on_outlined,
        ),
      ),
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

  Widget _listTile(String title, String subtitle, {required IconData leadingIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            child: Icon(
              leadingIcon,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
                Text(subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
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
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
