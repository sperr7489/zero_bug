import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Image image;
  final String satisfaction;

  const ImageCard({
    super.key,
    required this.image,
    required this.satisfaction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image,
        Text(
          satisfaction,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
