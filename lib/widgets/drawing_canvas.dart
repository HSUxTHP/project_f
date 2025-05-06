import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/frame_data.dart';
import 'bottom_toolbar.dart';

class Stroke {
  final List<Offset?> points;
  final Color color;
  final double width;

  Stroke({required this.points, required this.color, required this.width});

  Stroke copy() => Stroke(
    points: List.from(points),
    color: color,
    width: width,
  );
}

class DrawingCanvas extends StatefulWidget {
  final FrameData? initialFrame;
  final List<FrameData> allFrames;
  final int currentIndex;
  final bool isPlaying;
  final Function(FrameData) onSave;

  final Color selectedColor;
  final double strokeWidth;
  final bool isEraser;
  final TextEditingController fpsController;

  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onStrokeWidthChanged;
  final VoidCallback onEraserToggled;
  final VoidCallback onClear;

  final bool showOnionSkin;
  final int onionSkinCount;

  const DrawingCanvas({
    super.key,
    required this.initialFrame,
    required this.allFrames,
    required this.currentIndex,
    required this.isPlaying,
    required this.onSave,
    required this.selectedColor,
    required this.strokeWidth,
    required this.isEraser,
    required this.onColorChanged,
    required this.onStrokeWidthChanged,
    required this.onEraserToggled,
    required this.onClear,
    required this.fpsController,
    required this.showOnionSkin,
    required this.onionSkinCount,
  });

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  final GlobalKey repaintKey = GlobalKey();
  List<Stroke> strokes = [];
  List<List<Stroke>> undoStack = [];
  List<List<Stroke>> redoStack = [];
  Rect? drawingArea;
  int _fps = 12;
  Timer? _playbackTimer;
  int _playIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadFrame(widget.initialFrame);
    widget.fpsController.addListener(_updateFps);
    if (widget.isPlaying) _startPlayback();
  }

  @override
  void didUpdateWidget(covariant DrawingCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialFrame != oldWidget.initialFrame) {
      _loadFrame(widget.initialFrame);
    }
    if (widget.isPlaying != oldWidget.isPlaying) {
      widget.isPlaying ? _startPlayback() : _stopPlayback();
    }
  }

  void _loadFrame(FrameData? frame) {
    setState(() {
      strokes = [];
      for (int i = 0; i < (frame?.strokes.length ?? 0); i++) {
        strokes.add(Stroke(
          points: frame!.strokes[i],
          color: frame.strokeColors[i],
          width: frame.strokeWidths[i],
        ));
      }
      undoStack.clear();
      redoStack.clear();
    });
  }

  void _updateFps() {
    final value = int.tryParse(widget.fpsController.text);
    if (value != null && value > 0 && value <= 60) {
      setState(() => _fps = value);
      if (widget.isPlaying) {
        _stopPlayback();
        _startPlayback();
      }
    }
  }

  void _startPlayback() {
    _playbackTimer?.cancel();
    _playIndex = 0;
    _playbackTimer = Timer.periodic(Duration(milliseconds: 1000 ~/ _fps), (_) {
      setState(() => _playIndex = (_playIndex + 1) % widget.allFrames.length);
    });
  }

  void _stopPlayback() {
    _playbackTimer?.cancel();
  }

  void _saveFrame() async {
    final imageBytes = await _captureImage();
    final frame = FrameData(
      image: imageBytes,
      strokes: strokes.map((s) => List<Offset?>.from(s.points)).toList(),
      strokeColors: strokes.map((s) => s.color).toList(),
      strokeWidths: strokes.map((s) => s.width).toList(),
    );
    widget.onSave(frame);
  }

  Future<Uint8List> _captureImage() async {
    final boundary = repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void _startStroke(Offset position) {
    if (!_isInsideDrawingArea(position)) return;

    undoStack.add(List.from(strokes.map((s) => s.copy())));
    redoStack.clear();
    setState(() {
      strokes.add(Stroke(
        points: [position],
        color: widget.isEraser ? Colors.white : widget.selectedColor,
        width: widget.strokeWidth,
      ));
    });
  }

  void _addPoint(Offset point) {
    if (!_isInsideDrawingArea(point)) return;

    if (strokes.isNotEmpty) {
      setState(() => strokes.last.points.add(point));
    }
  }

  void _endStroke() {
    if (strokes.isNotEmpty) {
      strokes.last.points.add(null);
    }
  }

  bool _isInsideDrawingArea(Offset point) {
    if (drawingArea == null) return true;
    final safeArea = drawingArea!.deflate(widget.strokeWidth / 2);
    return safeArea.contains(point);
  }

  void _undo() {
    if (undoStack.isNotEmpty) {
      redoStack.add(List.from(strokes.map((s) => s.copy())));
      setState(() => strokes = undoStack.removeLast());
    }
  }

  void _redo() {
    if (redoStack.isNotEmpty) {
      undoStack.add(List.from(strokes.map((s) => s.copy())));
      setState(() => strokes = redoStack.removeLast());
    }
  }

  @override
  void dispose() {
    widget.fpsController.removeListener(_updateFps);
    _playbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDrawing = !widget.isPlaying;
    final playingFrame = widget.allFrames[_playIndex % widget.allFrames.length];

    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), // ✅ bo tròn hơn
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300), // ✅ border sáng
              ),

              child: Stack(
                children: [
                  if (isDrawing && widget.showOnionSkin)
                    for (int i = 1; i <= widget.onionSkinCount; i++)
                      if (widget.currentIndex - i >= 0)
                        Positioned.fill(
                          child: Image.memory(
                            widget.allFrames[widget.currentIndex - i].image,
                            fit: BoxFit.contain,
                            color: Colors.white.withOpacity((0.3 - (i - 1) * 0.1).clamp(0.05, 0.3)),
                            colorBlendMode: BlendMode.modulate,
                          ),
                        ),

                  if (widget.isPlaying && playingFrame.image.isNotEmpty)
                    Positioned.fill(
                      child: Image.memory(
                        playingFrame.image,
                        fit: BoxFit.contain,
                      ),
                    ),

                  if (isDrawing)
                    GestureDetector(
                      onPanStart: (details) => _startStroke(details.localPosition),
                      onPanUpdate: (details) => _addPoint(details.localPosition),
                      onPanEnd: (_) => _endStroke(),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            final box = context.findRenderObject() as RenderBox?;
                            if (box != null) {
                              drawingArea = Offset.zero & box.size;
                            }
                          });
                          return RepaintBoundary(
                            key: repaintKey,
                            child: CustomPaint(
                              painter: _DrawingPainter(strokes),
                              size: Size.infinite,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        BottomToolbar(
          selectedColor: widget.selectedColor,
          strokeWidth: widget.strokeWidth,
          isEraser: widget.isEraser,
          isPlaying: widget.isPlaying,
          fpsValue: _fps.toString(),
          onColorChanged: widget.onColorChanged,
          onStrokeWidthChanged: widget.onStrokeWidthChanged,
          onEraserToggled: widget.onEraserToggled,
          onClear: widget.onClear,
          onSave: _saveFrame,
          onUndo: _undo,
          onRedo: _redo,
          onFpsChanged: (val) {
            widget.fpsController.text = val;
            _updateFps();
          },
        ),

      ],
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<Stroke> strokes;

  _DrawingPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.width
        ..strokeCap = StrokeCap.round;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        final p1 = stroke.points[i];
        final p2 = stroke.points[i + 1];
        if (p1 != null && p2 != null) {
          canvas.drawLine(p1, p2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}