import 'package:flutter/material.dart';

class SecondTopToolbar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onCopy;
  final VoidCallback onPaste;
  final VoidCallback onGenerateTween;
  final VoidCallback onToggleOnionSkin;
  final bool showOnionSkin;
  final int onionSkinCount;
  final ValueChanged<int> onOnionSkinCountChanged;
  final VoidCallback onTogglePlay;
  final bool isPlaying;

  const SecondTopToolbar({
    super.key,
    required this.onBack,
    required this.onCopy,
    required this.onPaste,
    required this.onGenerateTween,
    required this.onToggleOnionSkin,
    required this.showOnionSkin,
    required this.onionSkinCount,
    required this.onOnionSkinCountChanged,
    required this.onTogglePlay,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white70,
        border: Border(
          bottom: BorderSide(
            color: Colors.black54,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
              child: _iconButton(Icons.arrow_back, onBack),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.black54,
                  width: 1,
                ),
              )
            ),
          ),
          _iconButton(Icons.copy, onCopy),
          _iconButton(Icons.paste, onPaste),
          _iconButton(Icons.auto_fix_high, onGenerateTween),
          _iconButton(
            showOnionSkin ? Icons.layers_clear : Icons.layers,
            onToggleOnionSkin,
          ),
          PopupMenuButton<int>(
            initialValue: onionSkinCount,
            onSelected: onOnionSkinCountChanged,
            icon: const Icon(Icons.filter_frames, size: 20),
            itemBuilder: (_) => [
              for (int i = 1; i <= 5; i++)
                PopupMenuItem(value: i, child: Text('$i Onion Frame')),
            ],
          ),
          _iconButton(
            isPlaying ? Icons.stop : Icons.play_arrow,
            onTogglePlay,
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: Colors.black87),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      tooltip: icon.toString(),
    );
  }
}
