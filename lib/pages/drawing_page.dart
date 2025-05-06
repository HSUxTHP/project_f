import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/frame_data.dart';
import '../utils/thumbnail_rendrer.dart';
import '../widgets/drawing_canvas.dart';
import '../utils/tweening.dart';
import '../widgets/second_top_toolbar.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  final List<FrameData> _frames = [];
  int _currentFrameIndex = 0;
  bool _isPlaying = false;
  Color _selectedColor = Colors.black;
  double _strokeWidth = 4.0;
  bool _isEraser = false;
  final TextEditingController _fpsController = TextEditingController(text: '12');
  bool _showOnionSkin = true;
  int _onionSkinCount = 2;
  FrameData? _copiedFrame;
  bool _showFrameList = true;
  String _viewMode = 'frame';

  @override
  void initState() {
    super.initState();
    _addBlankFrame();
  }

  void _addBlankFrame() {
    _frames.add(FrameData.empty());
    _currentFrameIndex = _frames.length - 1;
    setState(() {});
  }

  void _saveFrame(FrameData frame) {
    setState(() {
      _frames[_currentFrameIndex] = frame;
      if (_currentFrameIndex == _frames.length - 1) {
        _addBlankFrame();
      } else {
        _currentFrameIndex++;
      }
    });
  }

  void _deleteFrame(int index) {
    if (_frames.length <= 1) return;
    setState(() {
      _frames.removeAt(index);
      if (_currentFrameIndex >= _frames.length) {
        _currentFrameIndex = _frames.length - 1;
      }
    });
  }

  void _togglePlay() => setState(() => _isPlaying = !_isPlaying);

  void _copyFrame() {
    final current = _frames[_currentFrameIndex];
    if (current.strokes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Frame này chưa có gì để copy')),
      );
      return;
    }
    setState(() => _copiedFrame = current.copy());
  }

  void _pasteFrame() {
    if (_copiedFrame != null) {
      setState(() {
        _frames.insert(_currentFrameIndex + 1, _copiedFrame!.copy());
        _currentFrameIndex += 1;
      });
    }
  }

  Future<void> _generateTween() async {
    if (_currentFrameIndex >= _frames.length - 1) return;
    final a = _frames[_currentFrameIndex];
    final b = _frames[_currentFrameIndex + 1];

    if (a.strokes.isEmpty || b.strokes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Cần có nội dung ở cả 2 frame để tween'),
        ),
      );
      return;
    }

    const tweenCount = 3;
    final tweenFrames = generateTweenFrames(a, b, tweenCount);

    for (int i = 0; i < tweenFrames.length; i++) {
      final image = await renderThumbnailFromStrokes(
        strokes: tweenFrames[i].strokes,
        strokeColors: tweenFrames[i].strokeColors,
        strokeWidths: tweenFrames[i].strokeWidths,
      );
      tweenFrames[i] = tweenFrames[i].copyWith(image: image);
    }

    setState(() {
      _frames.insertAll(_currentFrameIndex + 1, tweenFrames);
      _currentFrameIndex += 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Đã thêm tween frames')),
    );
  }

  void _selectFrame(int index) => setState(() => _currentFrameIndex = index);

  @override
  Widget build(BuildContext context) {
    final currentFrame = _frames[_currentFrameIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // ✅ nền sáng
      body: Column(
        children: [
          SecondTopToolbar(
            onBack: () => Navigator.of(context).pop(),
            onCopy: _copyFrame,
            onPaste: _pasteFrame,
            onGenerateTween: _generateTween,
            onToggleOnionSkin: () => setState(() => _showOnionSkin = !_showOnionSkin),
            showOnionSkin: _showOnionSkin,
            onionSkinCount: _onionSkinCount,
            onOnionSkinCountChanged: (val) => setState(() => _onionSkinCount = val),
            onTogglePlay: _togglePlay,
            isPlaying: _isPlaying,
          ),

          Expanded(
            child: Row(
              children: [
                if (_showFrameList)
                  Container(
                    margin: const EdgeInsets.only(right: 4, top: 4),
                    width: 200,
                    color: const Color(0xFFE8EAED), // ✅ sidebar xám sáng
                    child: Stack(
                      children: [
                        Positioned(
                          top: -10,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                            color: const Color(0xFFCDD2DC), // ✅ header sáng
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () => setState(() => _viewMode = 'frame'),
                                  child: Text(
                                    'Frame',
                                    style: TextStyle(
                                      color: _viewMode == 'frame' ? Colors.black87 : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => setState(() => _viewMode = 'layout'),
                                  child: Text(
                                    'Layout',
                                    style: TextStyle(
                                      color: _viewMode == 'layout' ? Colors.black87 : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _viewMode == "frame"
                            ? Padding(
                          padding: const EdgeInsets.only(top: 48),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: _frames.length,
                            itemBuilder: (context, index) {
                              final frame = _frames[index];
                              final isSelected = index == _currentFrameIndex;

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _selectFrame(index),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected ? Colors.indigo : Colors.grey.shade400,
                                            width: 2.5,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                          color: const Color(0xFFFDFDFD),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: AspectRatio(
                                            aspectRatio: 1.5,
                                            child: frame.image.isNotEmpty
                                                ? Image.memory(frame.image, fit: BoxFit.cover)
                                                : Container(
                                              alignment: Alignment.center,
                                              color: Colors.grey[200],
                                              child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: GestureDetector(
                                        onTap: () => _deleteFrame(index),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.redAccent,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(6),
                                          child: const Icon(Icons.delete, size: 16, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                            : const Padding(
                          padding: EdgeInsets.only(top: 48),
                          child: Center(child: Placeholder()),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(
                            icon: const Icon(Icons.menu_open, size: 26, color: Colors.black87),
                            onPressed: () => setState(() => _showFrameList = false),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!_showFrameList)
                  Expanded(
                    child: Stack(
                      children: [
                        _buildCanvas(currentFrame),
                        Positioned(
                          top: 4,
                          left: 4,
                          child: IconButton(
                            icon: const Icon(Icons.menu, size: 26, color: Colors.black87),
                            onPressed: () => setState(() => _showFrameList = true),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_showFrameList)
                  Expanded(child: _buildCanvas(currentFrame)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCanvas(FrameData currentFrame) {
    return DrawingCanvas(
      key: ValueKey(_currentFrameIndex),
      initialFrame: currentFrame,
      allFrames: _frames,
      isPlaying: _isPlaying,
      currentIndex: _currentFrameIndex,
      onSave: _saveFrame,
      selectedColor: _selectedColor,
      strokeWidth: _strokeWidth,
      isEraser: _isEraser,
      onColorChanged: (c) => setState(() => _selectedColor = c),
      onStrokeWidthChanged: (v) => setState(() => _strokeWidth = v),
      onEraserToggled: () => setState(() => _isEraser = !_isEraser),
      onClear: () => setState(() => _frames[_currentFrameIndex] = FrameData.empty()),
      fpsController: _fpsController,
      showOnionSkin: _showOnionSkin,
      onionSkinCount: _onionSkinCount,
    );
  }

  @override
  void dispose() {
    _fpsController.dispose();
    super.dispose();
  }
}
