import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelect;

  const Sidebar({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70, // ⬅ tăng chiều rộng
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildNavItem(Icons.home, "Home", 0),
            _divider(),
            _buildNavItem(Icons.question_mark, "Ask", 1),
            _divider(),
            _buildNavItem(Icons.person, "Me", 2),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected ? Colors.white : Colors.grey[400];
    final bgColor = isSelected ? Colors.grey[850] : Colors.transparent;

    return Container(
      color: bgColor,
      width: double.infinity,
      child: InkWell(
        onTap: () => onSelect(index),
        splashColor: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 26, color: color), // ⬆ icon lớn hơn một chút
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10, // ⬆ chữ to hơn
                  color: color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() => Divider(
    color: Colors.grey.shade800,
    thickness: 0.3,
    height: 1,
  );
}
