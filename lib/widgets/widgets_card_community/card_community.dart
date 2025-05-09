import 'package:flutter/material.dart';

class CardCommunity extends StatelessWidget {
  final String imageUrl;
  final String duration;
  final String name;
  final String uploader;
  final int likes;
  final int comments;

  const CardCommunity({
    super.key,
    required this.imageUrl,
    required this.duration,
    required this.name,
    required this.uploader,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 👈 Gói vừa nội dung
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.person_2, size: 14, color: Colors.black),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  uploader,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.favorite_border, size: 16),
              const SizedBox(width: 4),
              Text("$likes Likes", style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(Icons.comment_outlined, size: 16),
              const SizedBox(width: 4),
              Text("$comments Comment", style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
