import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  final List<Color> recentColors;
  final void Function(Color newColor) onColorSelected;

  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    required this.recentColors,
    required this.onColorSelected,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color currentColor = Colors.black;

  @override
  void initState() {
    super.initState();
    currentColor = widget.initialColor;
  }

  void _onColorChanged(Color color) {
    setState(() => currentColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('🎨 Chọn màu'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bộ chọn màu chính
            ColorPicker(
              pickerColor: currentColor,
              onColorChanged: _onColorChanged,
              enableAlpha: true, // Opacity
              displayThumbColor: true,
              paletteType: PaletteType.hsvWithHue,
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              children: [
                ...[
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.orange,
                  Colors.purple,
                  Colors.brown,
                  Colors.grey,
                  Colors.black,
                  Colors.white,
                ].map((color) => GestureDetector(
                  onTap: () => _onColorChanged(color),
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 14,
                    child: currentColor.value == color.value
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ))
              ],
            ),

            const SizedBox(height: 16),

            // Lịch sử màu
            if (widget.recentColors.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🕘 Gần đây', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: widget.recentColors.map((color) {
                      return GestureDetector(
                        onTap: () => _onColorChanged(color),
                        child: CircleAvatar(
                          backgroundColor: color,
                          radius: 12,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onColorSelected(currentColor);
            Navigator.pop(context);
          },
          child: const Text('Chọn'),
        ),
      ],
    );
  }
}
