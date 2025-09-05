import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:near_by/features/activity/presentation/widgets/add_item_sheet.dart';
import 'package:near_by/features/home/presentation/widgets/fab_buttons.dart';

class LostItemsView extends StatefulWidget {
  const LostItemsView({super.key});

  @override
  State<LostItemsView> createState() => _LostItemsViewState();
}

class _LostItemsViewState extends State<LostItemsView> {
  final List<Map<String, dynamic>> _lostItems = [];

  void _openAddLostItemSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
        child: AddItemSheet(
          onSubmit: (newItem) {
            setState(() => _lostItems.add(newItem));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _lostItems.isEmpty
            ? const Center(
                child: Text(
                  "No lost items reported yet",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
            : ListView.builder(
                itemCount: _lostItems.length,
                itemBuilder: (context, index) {
                  final item = _lostItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 3),
                            blurRadius: 10,
                            color: Colors.grey.shade200,
                            spreadRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: item['image'] != null
                                      ? FileImage(item['image'])
                                      : null,
                                  child: item['image'] == null
                                      ? const Icon(
                                          Icons.image,
                                          size: 35,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['product'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      InfoRow(
                                        icon: const Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Colors.blue,
                                        ),
                                        label: "Lost at",
                                        value: item['location'],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            InfoRow(label: "Contact Name", value: item['name']),
                            InfoRow(label: "Phone", value: item['phone']),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan.shade800,
        heroTag: 'directionBtn',
        onPressed: () {
          _openAddLostItemSheet();
        },
        tooltip: 'Report Lost Item',
        icon: const Icon(Icons.report, color: Colors.white),
        label: const Text(
          "Report Lost Item",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? icon;
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Padding(padding: const EdgeInsets.only(right: 4.0), child: icon!),
          ] else
            Text(
              "$label: ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
