import 'package:flutter/material.dart';
import 'package:flutter_testing/pages/community_page.dart';
import 'package:flutter_testing/pages/home_page.dart';
import 'package:flutter_testing/pages/profile_page.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  List<Widget> pages = [
    HomePage(),
    CommunityPage(),
    ProfilePage()
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              "https://static.vecteezy.com/system/resources/thumbnails/012/657/549/small_2x/illustration-negative-film-reel-roll-tapes-for-movie-cinema-video-logo-vector.jpg",
              fit: BoxFit.cover,
              width: 40, // Set a specific width
              height: 40,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 12,
          children: [
            Text("App Name", style: TextStyle(color: Colors.white)),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: SearchBar(
                  trailing: [Icon(Icons.search),],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                "https://static.vecteezy.com/system/resources/thumbnails/012/657/549/small_2x/illustration-negative-film-reel-roll-tapes-for-movie-cinema-video-logo-vector.jpg",
                fit: BoxFit.cover,
                width: 40, // Set a specific width
                height: 40,
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.home, color: Colors.white, size: 28),
                            SizedBox(height: 4),
                            Text("Home", style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.question_mark, color: Colors.white, size: 28),
                            SizedBox(height: 4),
                            Text("Community", style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person, color: Colors.white, size: 28),
                            SizedBox(height: 4),
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 10,
              child: pages[_currentIndex],
          ),
        ],
      ),
    );
    ;
  }
}
