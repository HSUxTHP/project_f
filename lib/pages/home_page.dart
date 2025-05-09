import 'package:flutter/material.dart';
import 'package:flutter_testing/pages/drawing_page.dart';
import 'package:flutter_testing/widgets/widgets_home/card_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = List.generate(20, (index) {
      return {
        'title': 'Project $index',
        'imageUrl': 'https://picsum.photos/500/300?random=$index',
        'createdAt': '2024-12-${(index % 30 + 1).toString().padLeft(2, '0')}',
      };
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Title row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.movie, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        "Projects",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline, size: 20),
                  ),
                ],
              ),
              const Divider(height: 24),
              // Grid
              Expanded(
                child: GridView.builder(
                  itemCount: projects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 16 / 13,
                  ),
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return CardHome(
                      imageUrl: project['imageUrl']!,
                      title: project['title']!,
                      createdAt: "Created: ${project['createdAt']}",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DrawingPage()),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
