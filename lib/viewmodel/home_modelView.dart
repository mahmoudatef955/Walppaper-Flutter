import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wallpaperapp/services/authentication.dart';

// var mv = Provider.of<HomePageViewModel>(context, listen: false);

class HomePageViewModel extends ChangeNotifier {
  Authentication _auth = Authentication();
  Box settingBox = Hive.box('settingBox');
  Box favBox = Hive.box('favBox');
  bool loginScreen = true;

  void toggleScreen() {
    loginScreen = !loginScreen;
    notifyListeners();
  }

  void skipAuthentication() {
    settingBox.put('isSkipped', false);
    notifyListeners();
  }

  Future<void> signInSubmit(
      GlobalKey<FormState> formKey, String email, String password) {
    final isValid = formKey.currentState.validate();
    if (isValid) {
    
    _auth.signInWithEmailAndPassword(email, password);
    settingBox.put('loggedIn', true);
    settingBox.put('isSkipped', false);
    formKey.currentState.save();
    notifyListeners();
    }
  }

  void registerInSubmit(GlobalKey<FormState> formKey, String email,
      String password, String userName) {
    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _auth.registerWithEmailAndPassword(email, password, userName).then((value) {
      settingBox.put('loggedIn', true);
      settingBox.put('isSkipped', false);
      settingBox.put('userName', userName);
      settingBox.put('uID', value);
      formKey.currentState.save();
      formKey.currentState.save();
      debugPrint(value);
      notifyListeners();
    });
  }

  Future signInWithGoogle() async {
    _auth.signInWithGoogle().then((result) {
      notifyListeners();

      if (result != null) {
        print(result.characters.string);
      }
    });
  }

  void signOut() {
    _auth.signOut().then((value) {
      settingBox.put('loggedIn', false);
      settingBox.put('isSkipped', true);
      settingBox.put('userName', null);
      settingBox.put('uID', null);
      notifyListeners();
    });
  }
}
