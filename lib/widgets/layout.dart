import 'package:flutter/material.dart';
import 'package:flutter_testing/pages/home_page.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

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
                padding: MaterialStateProperty.all(EdgeInsets.all(0))
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
            child: Drawer(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              backgroundColor: Colors.black,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home, color: Colors.white, size: 28),
                                SizedBox(height: 4),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Community",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 28,
                                ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 10, child: HomePage()),
        ],
      ),
    );
    ;
  }
}
