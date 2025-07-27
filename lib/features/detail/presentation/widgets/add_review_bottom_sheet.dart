import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddReviewBottomSheet extends StatefulWidget {
  const AddReviewBottomSheet({super.key});

  @override
  State<AddReviewBottomSheet> createState() => _AddReviewBottomSheetState();
}

class _AddReviewBottomSheetState extends State<AddReviewBottomSheet> {
  int rating = 0;
  final TextEditingController descriptionController = TextEditingController();
  File? selectedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitReview() {
    final rootContext = Navigator.of(context).overlay!.context;

    if (rating == 0) {
      ScaffoldMessenger.of(
        rootContext,
      ).showSnackBar(const SnackBar(content: Text('Please select a rating')));
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
        const SnackBar(content: Text('Please write a description')),
      );
      return;
    }

    // Optional: Check if image is mandatory
    // if (selectedImage == null) {
    //   ScaffoldMessenger.of(rootContext).showSnackBar(
    //     const SnackBar(content: Text('Please add a photo')),
    //   );
    //   return;
    // }

    // Submit review logic here
    ScaffoldMessenger.of(rootContext).showSnackBar(
      const SnackBar(content: Text('Review submitted successfully')),
    );
    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildStar(int index) {
    return IconButton(
      icon: Icon(
        Icons.star,
        size: 30,
        color: index < rating ? Colors.amber : Colors.grey.shade300,
      ),
      onPressed: () {
        setState(() {
          rating = index + 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Add Your Review",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            /// Rating Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index)),
            ),
            const SizedBox(height: 20),

            /// Description
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write your experience...',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// Photo Picker
            Text(
              "Upload a photo (optional)",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(selectedImage!, fit: BoxFit.cover),
                      )
                    : const Center(child: Text("Tap to add a photo")),
              ),
            ),
            const SizedBox(height: 24),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit Review",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
