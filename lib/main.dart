// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_testing/widgets/widgets_layout/layout.dart';
import 'pages/drawing_page.dart';

void main() {
  runApp(const DrawingApp());
}

class DrawingApp extends StatelessWidget {
  const DrawingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Sketch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const Layout(),
    );
  }
}
