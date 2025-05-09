import 'package:flutter/material.dart';
import 'package:flutter_testing/widgets/widgets_card_community/card_community.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  final List<String> tabs = const ['Trending', 'Newest', 'Most Liked'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Community'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[50],
          foregroundColor: Colors.black,
          elevation: 1,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            indicatorColor: Colors.blueAccent,
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: TabBarView(
            children: tabs.map((tab) {
              return GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 3.2,
                ),
                itemBuilder: (context, index) {
                  return CardCommunity(
                    imageUrl: 'https://picsum.photos/500/300?random=$index',
                    duration: '3:24',
                    name: '$tab Project $index',
                    uploader: 'User $index',
                    likes: 20 + index,
                    comments: 5 + index,
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
