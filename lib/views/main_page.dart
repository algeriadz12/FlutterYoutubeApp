
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player/models/channel.dart';
import 'package:youtube_player/views/home_page.dart';

import 'download_screen.dart';

 var videoStateProvider = StateProvider<Video?>((ref) => null);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _screens = [
     const HomePage(),
     const Scaffold(body: Center(child: Text("Explore Screen"),),),
     const DownloadScreen(),
     const Scaffold(body: Center(child: Text("Subscriptions Screen"),),),
     const Scaffold(body: Center(child: Text("Library Screen"),),)
  ];

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home",activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined),label: "Explore",activeIcon: Icon(Icons.explore)),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "Add", activeIcon: Icon(Icons.add_circle)),
          BottomNavigationBarItem(icon: Icon(Icons.subscriptions_outlined),label: "Subscriptions",activeIcon: Icon(Icons.subscriptions)),
          BottomNavigationBarItem(icon: Icon(Icons.video_label_outlined),label: "Library",activeIcon: Icon(Icons.video_label))
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
      body: Stack(
        // TODO : Using OffStage widget to camouflage the screen and reduce the consumption of device
        // TODO : resources
        children: _screens.asMap().map((i, screen) =>
            MapEntry(i, Offstage(offstage: _selectedIndex != i, child: screen,))).values.toList(),
      ),
    );
  }
}
