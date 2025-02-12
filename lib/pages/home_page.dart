import 'package:flutter/material.dart';
import 'package:journey/pages/journey/journey_page.dart';
import 'package:journey/pages/posts/create_post_page.dart';
import 'package:journey/pages/profile_page.dart';

import 'posts/posts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    const PostsPage(),
    const Journeypage(),
    const CreatePostPage(),
    const Profile(),
    
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _selectedIndex,
          onTap: onTapNav,
          items: const [
            
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              tooltip: "posts",
              label: "posts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.diversity_1),
              tooltip: "journeys",
              label: "journeys",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
              ),
              tooltip: "create",
              label: "create",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              tooltip: "notifications",
              label: "notifications",
            ),
           
          ]),
    );
  }
}
