import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  final Size size;
  const ImageHeader({required this.size});

  @override
  Widget build(BuildContext context) {
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
}
