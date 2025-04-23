import 'dart:typed_data';
import 'dart:ui';
import '../models/frame_data.dart';

List<FrameData> generateTweenFrames(FrameData a, FrameData b, int count) {
  List<FrameData> tweenFrames = [];

  for (int i = 1; i <= count; i++) {
    final t = i / (count + 1);

    List<List<Offset?>> tweenStrokes = [];
    List<Color> tweenColors = [];
    List<double> tweenWidths = [];

    final minLength = a.strokes.length < b.strokes.length
        ? a.strokes.length
        : b.strokes.length;

    for (int j = 0; j < minLength; j++) {
      final s1 = a.strokes[j];
      final s2 = b.strokes[j];
      final stroke = <Offset?>[];

      final strokeMinLength = s1.length < s2.length ? s1.length : s2.length;
      for (int k = 0; k < strokeMinLength; k++) {
        final p1 = s1[k];
        final p2 = s2[k];
        if (p1 != null && p2 != null) {
          stroke.add(Offset.lerp(p1, p2, t));
        } else {
          stroke.add(null);
        }
      }

      tweenStrokes.add(stroke);
      tweenColors.add(Color.lerp(a.strokeColors[j], b.strokeColors[j], t)!);
      tweenWidths.add(lerpDouble(a.strokeWidths[j], b.strokeWidths[j], t)!);
    }

    tweenFrames.add(FrameData(
      image: Uint8List(0),
      strokes: tweenStrokes,
      strokeColors: tweenColors,
      strokeWidths: tweenWidths,
    ));
  }

  return tweenFrames;
}
