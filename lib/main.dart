import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/view/home_screen/home_screen.dart';
import 'package:wallpaperapp/view/welcome_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:wallpaperapp/viewmodel/home_modelView.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// key = 2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw

const settingBox = 'settingBox';
const favBox = 'favBox';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(settingBox);
  await Hive.openBox(favBox);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSkipped;
  bool _loggedIn;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>HomePageViewModel(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      title: 'Wallpaper App',
      home: ValueListenableBuilder(
        valueListenable: Hive.box(settingBox).listenable(),
        builder: (context, box, widget) {
          _isSkipped = box.get('isSkipped', defaultValue: true);
          _loggedIn = box.get('loggedIn', defaultValue: false);
          return (_isSkipped && !_loggedIn) ? WelcomeScreen() : HomeScreen();
        },
        //child: WelcomeScreen(),
      ),
      builder: (BuildContext context, Widget child) {
        /// make sure that loading can be displayed in front of all other widgets
        return FlutterEasyLoading(child: child);
      },
    ),
      );
  }
}
