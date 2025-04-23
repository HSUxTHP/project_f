import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<Uint8List> renderThumbnailFromStrokes({
  required List<List<Offset?>> strokes,
  required List<Color> strokeColors,
  required List<double> strokeWidths,
  double width = 300,
  double height = 200,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..style = PaintingStyle.stroke;

  canvas.drawRect(
    Rect.fromLTWH(0, 0, width, height),
    Paint()..color = Colors.white,
  );

  for (int i = 0; i < strokes.length; i++) {
    final s = strokes[i];
    paint.color = strokeColors[i];
    paint.strokeWidth = strokeWidths[i];
    paint.strokeCap = StrokeCap.round;

    for (int j = 0; j < s.length - 1; j++) {
      final p1 = s[j];
      final p2 = s[j + 1];
      if (p1 != null && p2 != null) {
        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  final picture = recorder.endRecording();
  final image = await picture.toImage(width.toInt(), height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
