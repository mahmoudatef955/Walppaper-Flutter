import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wallpaperapp/services/authentication.dart';
import 'package:wallpaperapp/services/webService.dart';

// var mv = Provider.of<HomePageViewModel>(context, listen: false);

class HomePageViewModel extends ChangeNotifier {
  Authentication _auth = Authentication();
  WebService _webService = WebService();
  Box settingBox = Hive.box('settingBox');
  Box<String> favoriteImageBox = Hive.box('favBox');
  bool loginScreen = true;

  void toggleScreen() {
    loginScreen = !loginScreen;
    notifyListeners();
  }

/////////////////////// authintication/////////////////////////////////////
  void skipAuthentication() {
    settingBox.put('isSkipped', false);
    settingBox.put('loggedIn', false);
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

  bool isLogged() {
    return settingBox.get('loggedIn');
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

  ////////////////////////////////////////////////////////////////////////////////
  ///                Favourite Wallpapers                                    ////
  ///////////////////////////////////////////////////////////////////////////////

  void onFavoritePress(String imageId, String imageUrl) {
    if (favoriteImageBox.containsKey(imageId)) {
      favoriteImageBox.delete(imageId);
      notifyListeners();
      return;
    }
    favoriteImageBox.put(imageId, imageUrl);
    notifyListeners();
  }

  Future<List> fetchImages(int pageNumber, String orderBy) {
    return _webService.fetchImages(pageNumber, orderBy);
  }

  Future<List> fetchMoreImages(int pageNumber, String orderBy) {
    return _webService.fetchMoreImages(pageNumber, orderBy);
  }
}
