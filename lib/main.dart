import 'package:flutter/material.dart';
import 'package:wallpaperapp/screens/collections.dart';
import 'package:wallpaperapp/screens/latest.dart';
import 'package:wallpaperapp/screens/popular.dart';

// key = 2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int selectedIndex;
  List<Widget> _children;
  List<String> appBarText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarText = ['Wallpapers', 'Collections', 'Favourites'];
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
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      title: 'Wallpaper App',
      home: Scaffold(
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
          backgroundColor: Colors.black,
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.settings),
            //   title: Text('Settings'),
            // ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            onItemTapped(index);
          },
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
