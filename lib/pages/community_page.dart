import 'package:flutter/material.dart';
import 'package:flutter_testing/widgets/widgets_card_community/card_community.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: Colors.black12,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.black,
              indicatorWeight: 2.5,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              tabs: [
                Tab(icon: Icon(Icons.grid_view), text: 'Tất Cả'),
                Tab(icon: Icon(Icons.star), text: 'Top'),
                Tab(icon: Icon(Icons.trending_up), text: 'Trending'),
                Tab(icon: Icon(Icons.favorite), text: 'Lượt thích'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ProjectGrid(category: "Tất cả"),
            ProjectGrid(category: "Top"),
            ProjectGrid(category: "Trending"),
            ProjectGrid(category: "Lượt thích"),
          ],
        ),
      ),
    );
  }
}

class ProjectGrid extends StatelessWidget {
  final String category;
  const ProjectGrid({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return CardCommunity(
          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3jL6gUvfFslb4OCAOMuiKL7lnxRIByo-e5I_ub2RSdqmkMVCX1rOa6YcfFUXRcxTvOSY&usqp=CAU",
          duration: "04:12",
          name: "Project ${index + 1}",
          uploader: "Người đăng",
          description: "Describe: No describe",
          likes: index * 2,
          comments: index,
        );
      },
    );
  }
}
