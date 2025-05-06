import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.black,
      elevation: 4,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 75, right: 16), // match sidebar width
        child: Row(
          children: [
            // LEFT SIDE: logo + name
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://static.vecteezy.com/system/resources/thumbnails/012/657/549/small_2x/illustration-negative-film-reel-roll-tapes-for-movie-cinema-video-logo-vector.jpg",
                    fit: BoxFit.cover,
                    width: 36,
                    height: 36,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "App Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // CENTER: Search bar
            SizedBox(
              width: width * 0.4,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            // RIGHT SIDE: Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                "https://static.vecteezy.com/system/resources/thumbnails/012/657/549/small_2x/illustration-negative-film-reel-roll-tapes-for-movie-cinema-video-logo-vector.jpg",
                fit: BoxFit.cover,
                width: 36,
                height: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
