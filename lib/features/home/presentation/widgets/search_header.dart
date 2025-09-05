import 'package:flutter/material.dart';
import 'package:near_by/features/home/presentation/widgets/login_sheet_wrapper.dart';
import 'package:near_by/features/search/presentation/search_page.dart';
import 'package:near_by/features/search/presentation/widgets/category_list.dart';

class SearchHeader extends StatelessWidget {
  final List<Map<String, String>> categories;
  final double sheetCurrentSize;

  const SearchHeader({
    super.key,
    required this.categories,
    required this.sheetCurrentSize,
  });

  @override
  Widget build(BuildContext context) {
    const double headerFadeStart = 0.16;
    const double headerFadeEnd = 0.4;

    double headerOpacity =
        1.0 -
        ((sheetCurrentSize - headerFadeStart) /
            (headerFadeEnd - headerFadeStart));
    headerOpacity = headerOpacity.clamp(0.0, 1.0);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: AnimatedOpacity(
          opacity: headerOpacity,
          duration: const Duration(milliseconds: 250),
          child: IgnorePointer(
            ignoring: headerOpacity == 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (context) => GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.notes, color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.0),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SearchPage(),
                                  ),
                                ),
                                child: const TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Search here...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.mic, color: Colors.grey),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (_) => const LoginSheetWrapper(),
                                );
                              },
                              child: const CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(
                                  'https://i.pravatar.cc/150?img=3',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CategoryList(items: categories),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

