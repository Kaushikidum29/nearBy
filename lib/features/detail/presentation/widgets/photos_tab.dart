import 'package:flutter/material.dart';

class PhotosTab extends StatelessWidget {
  const PhotosTab({super.key});

  final List<String> photoUrls = const [
    'https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2020/03/21/Pictures/_d34c9cc6-6b2f-11ea-9fca-2c342717c29e.jpg',
    'https://kimshospital.in/wp-content/uploads/2022/11/10-scaled.jpg',
    'https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2020/03/21/Pictures/_d34c9cc6-6b2f-11ea-9fca-2c342717c29e.jpg',
    'https://kimshospital.in/wp-content/uploads/2022/11/10-scaled.jpg',
    'https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2020/03/21/Pictures/_d34c9cc6-6b2f-11ea-9fca-2c342717c29e.jpg',
    'https://kimshospital.in/wp-content/uploads/2022/11/10-scaled.jpg',
    'https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2020/03/21/Pictures/_d34c9cc6-6b2f-11ea-9fca-2c342717c29e.jpg',
    'https://kimshospital.in/wp-content/uploads/2022/11/10-scaled.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: photoUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final imageUrl = photoUrls[index];
        return GestureDetector(
          onTap: () => _showFullImage(context, imageUrl),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(15),
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
