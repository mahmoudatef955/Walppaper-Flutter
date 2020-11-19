import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/view/authentication/register_screen.dart';
import 'package:wallpaperapp/view/authentication/signIn_screen.dart';
import 'package:wallpaperapp/view/home_screen/home_screen.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _loginScreen = true;
  void toggleScreen() {
    setState(() {
      _loginScreen = !_loginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<HomePageViewModel>().loginScreen
        ? LoginScreen()
        : RegisterScreen();

    // _loginScreen
    //     ? LoginScreen(
    //         toggleScreen: toggleScreen,
    //       )
    //     : RegisterScreen(
    //         toggleScreen: toggleScreen,
    //       );
  }
}
