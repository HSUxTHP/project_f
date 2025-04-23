import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BottomToolbar extends StatelessWidget {
  final Color selectedColor;
  final double strokeWidth;
  final bool isEraser;
  final bool isPlaying;
  final String fpsValue;

  final VoidCallback onEraserToggled;
  final VoidCallback onClear;
  final VoidCallback onSave;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onStrokeWidthChanged;
  final ValueChanged<String> onFpsChanged;

  final List<Color> recentColors;

  const BottomToolbar({
    super.key,
    required this.selectedColor,
    required this.strokeWidth,
    required this.isEraser,
    required this.isPlaying,
    required this.fpsValue,
    required this.onEraserToggled,
    required this.onClear,
    required this.onSave,
    required this.onColorChanged,
    required this.onStrokeWidthChanged,
    required this.onFpsChanged,
    this.onUndo,
    this.onRedo,
    this.recentColors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Color Picker
          GestureDetector(
            onTap: () => _showAdvancedColorDialog(context),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: selectedColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black45),
              ),
            ),
          ),

          //  Brush Size
          GestureDetector(
            onTap: () => _showSizeDialog(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black45),
              ),
              child: Text(
                strokeWidth.round().toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Eraser Toggle
          IconButton(
            icon: Icon(isEraser ? Icons.brush : Icons.cleaning_services),
            tooltip: isEraser ? 'Switch to Brush' : 'Switch to Eraser',
            onPressed: onEraserToggled,
          ),

          //  Undo
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: 'Undo',
            onPressed: onUndo,
          ),

          //  Redo
          IconButton(
            icon: const Icon(Icons.redo),
            tooltip: 'Redo',
            onPressed: onRedo,
          ),

          //  Clear
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear Canvas',
            onPressed: onClear,
          ),

          // ️ FPS chỉnh
          IconButton(
            icon: const Icon(Icons.speed),
            tooltip: 'Set FPS',
            onPressed: () => _showFpsDialog(context),
          ),

          //  Save
          FilledButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAdvancedColorDialog(BuildContext context) async {
    Color tempColor = selectedColor;

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('🎨 Chọn màu nâng cao'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ColorPicker(
                pickerColor: tempColor,
                onColorChanged: (color) => tempColor = color,
                enableAlpha: true,
                labelTypes: const [ColorLabelType.hex],
                displayThumbColor: true,
                pickerAreaHeightPercent: 0.7,
              ),
              const SizedBox(height: 12),
              const Divider(),
              const Text('🎯 Màu mẫu'),
              Wrap(
                spacing: 6,
                children: [
                  ...[
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                    Colors.yellow,
                    Colors.orange,
                    Colors.purple,
                    Colors.brown,
                    Colors.grey,
                    Colors.black,
                    Colors.white,
                  ].map((color) => GestureDetector(
                    onTap: () => tempColor = color,
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 12,
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 12),
              if (recentColors.isNotEmpty) ...[
                const Divider(),
                const Text('🕘 Màu gần đây'),
                Wrap(
                  spacing: 6,
                  children: recentColors
                      .map((color) => GestureDetector(
                    onTap: () => tempColor = color,
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 12,
                    ),
                  ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              onColorChanged(tempColor);
              Navigator.pop(ctx);
            },
            child: const Text('Chọn'),
          ),
        ],
      ),
    );
  }

  void _showSizeDialog(BuildContext context) async {
    double tempValue = strokeWidth;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('✏️ Cỡ nét vẽ'),
        content: StatefulBuilder(
          builder: (context, setState) => Slider(
            value: tempValue,
            min: 1,
            max: 50,
            divisions: 49,
            label: tempValue.round().toString(),
            onChanged: (value) => setState(() => tempValue = value),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onStrokeWidthChanged(tempValue);
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFpsDialog(BuildContext context) async {
    double tempFps = double.tryParse(fpsValue) ?? 12;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('⚙️ Tốc độ phát (FPS)'),
        content: StatefulBuilder(
          builder: (context, setState) => Slider(
            value: tempFps,
            min: 1,
            max: 60,
            divisions: 59,
            label: tempFps.round().toString(),
            onChanged: (v) => setState(() => tempFps = v),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              onFpsChanged(tempFps.round().toString());
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
