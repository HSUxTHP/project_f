import 'dart:ui';
import 'package:flutter/material.dart';

class LayerData {
  final String name;
  final List<List<Offset?>> strokes;
  final List<Color> strokeColors;
  final List<double> strokeWidths;
  final bool visible;

  LayerData({
    required this.name,
    required this.strokes,
    required this.strokeColors,
    required this.strokeWidths,
    this.visible = true,
  });

  LayerData copyWith({
    String? name,
    List<List<Offset?>>? strokes,
    List<Color>? strokeColors,
    List<double>? strokeWidths,
    bool? visible,
  }) {
    return LayerData(
      name: name ?? this.name,
      strokes: strokes ?? strokesCopy(),
      strokeColors: strokeColors ?? List.from(strokeColors ?? this.strokeColors),
      strokeWidths: strokeWidths ?? List.from(strokeWidths ?? this.strokeWidths),
      visible: visible ?? this.visible,
    );
  }

  LayerData copy() => copyWith();

  List<List<Offset?>> strokesCopy() =>
      strokes.map((s) => List<Offset?>.from(s)).toList();

  static LayerData empty(String name) {
    return LayerData(name: name, strokes: [], strokeColors: [], strokeWidths: []);
  }
}
