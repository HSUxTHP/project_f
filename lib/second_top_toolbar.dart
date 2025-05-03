import 'package:flutter/material.dart';

class SecondTopToolbar extends StatelessWidget {
  const SecondTopToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      color: Color(0xFF43474E),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add settings logic
          ),
          IconButton(
            icon: const Icon(Icons.save),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add save logic
          ),
          IconButton(
            icon: const Icon(Icons.share),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add share logic
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.undo),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add share logic
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add redo logic
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.select_all),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add select_all logic
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.question_mark),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          IconButton(
            icon: const Icon(Icons.question_mark),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.question_mark),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          IconButton(
            icon: const Icon(Icons.format_color_fill),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add color logic
          ),
          IconButton(
            icon: const Icon(Icons.question_mark),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          IconButton(
            icon: const Icon(Icons.question_mark),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          IconButton(
            icon: const Icon(Icons.colorize),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.square_outlined),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          IconButton(
            icon: const Icon(Icons.brightness_1_outlined),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          IconButton(
            icon: const Icon(Icons.change_history),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.mic),
            color: Color(0xFFE1E2E9),
            onPressed: () {}, // TODO: Add logic
          ),
        ],
      ),
    );
  }
}