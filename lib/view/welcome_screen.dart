import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/view/authentication/register_screen.dart';
import 'package:wallpaperapp/view/authentication/signIn_screen.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return context.watch<HomePageViewModel>().loginScreen
        ? LoginScreen()
        : RegisterScreen();
  }
}
