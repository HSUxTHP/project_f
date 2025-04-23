// lib/widgets/frame_list_widget.dart
import 'package:flutter/material.dart';
import '../models/frame_data.dart';

class FrameListWidget extends StatelessWidget {
  final List<FrameData> frames;
  final void Function(int index) onSelect;
  final void Function(int index) onDelete;

  const FrameListWidget({
    super.key,
    required this.frames,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: frames.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final frame = frames[index];
        return Stack(
          children: [
            GestureDetector(
              onTap: () => onSelect(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.memory(
                    frame.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: () => onDelete(index),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black45,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
