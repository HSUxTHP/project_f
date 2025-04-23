import 'dart:typed_data';
import 'dart:ui';

class FillTool {
  static void floodFill({
    required Uint8List pixels,
    required int width,
    required int height,
    required int x,
    required int y,
    required Color newColor,
  }) {
    final targetColor = _getColorAt(pixels, x, y, width);
    if (_isSameColor(targetColor, newColor)) return;

    final visited = List.generate(height, (_) => List<bool>.filled(width, false));
    final queue = <Offset>[Offset(x.toDouble(), y.toDouble())];

    while (queue.isNotEmpty) {
      final point = queue.removeLast();
      final px = point.dx.toInt();
      final py = point.dy.toInt();

      if (px < 0 || py < 0 || px >= width || py >= height || visited[py][px]) continue;

      final currentColor = _getColorAt(pixels, px, py, width);
      if (!_isSameColor(currentColor, targetColor)) continue;

      _setColorAt(pixels, px, py, width, newColor);
      visited[py][px] = true;

      queue.addAll([
        Offset(px + 1.0, py.toDouble()),
        Offset(px - 1.0, py.toDouble()),
        Offset(px.toDouble(), py + 1.0),
        Offset(px.toDouble(), py - 1.0),
      ]);
    }
  }

  static Color _getColorAt(Uint8List pixels, int x, int y, int width) {
    final index = (y * width + x) * 4;
    return Color.fromARGB(
      pixels[index + 3],
      pixels[index],
      pixels[index + 1],
      pixels[index + 2],
    );
  }

  static void _setColorAt(Uint8List pixels, int x, int y, int width, Color color) {
    final index = (y * width + x) * 4;
    pixels[index] = color.red;
    pixels[index + 1] = color.green;
    pixels[index + 2] = color.blue;
    pixels[index + 3] = color.alpha;
  }

  static bool _isSameColor(Color a, Color b, {int tolerance = 30}) {
    return (a.red - b.red).abs() <= tolerance &&
        (a.green - b.green).abs() <= tolerance &&
        (a.blue - b.blue).abs() <= tolerance &&
        (a.alpha - b.alpha).abs() <= tolerance;
  }
}
