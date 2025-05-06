import 'package:flutter/material.dart';
import 'package:flutter_testing/pages/community_page.dart';
import 'package:flutter_testing/pages/home_page.dart';
import 'package:flutter_testing/pages/profile_page.dart';
import 'navbar.dart';
import 'sidebar.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<Widget> pages = [
    const HomePage(),
    const CommunityPage(),
    const ProfilePage(),
  ];

  int _currentIndex = 0;

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          Sidebar(
            currentIndex: _currentIndex,
            onSelect: _setIndex,
          ),
          Expanded(
            child: pages[_currentIndex],
          ),
        ],
      ),
    );
  }
}
