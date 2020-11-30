import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wallpaperapp/view/home_screen/setting.dart';

import 'collections.dart';
import 'favourite.dart';
import 'latest.dart';
import 'popular.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int selectedIndex;
  List<Widget> _children;
  List<String> appBarText;

  @override
  void initState() {
    EasyLoading.dismiss();

    super.initState();
    appBarText = ['Wallpapers', 'Collections', 'Favourites', 'Setting'];
    _tabController = new TabController(length: 2, vsync: this);
    selectedIndex = 0;
    _children = [
      TabBarView(
        children: [
          LatestScreen(),
          PopularScreen(),
        ],
        controller: _tabController,
      ),
      Collections(),
      Favourite(),
      Setting(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText[selectedIndex]),
        bottom: selectedIndex != 0
            ? null
            : TabBar(
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'LATEST',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'POPULAR',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                controller: _tabController,
              ),
      ),
      body: _children[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wallpaper),
            title: Text('Wallpapers'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            title: Text('Collections'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favourites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.amberAccent,
        onTap: (index) {
          onItemTapped(index);
        },
      ),
    );
  }
}
