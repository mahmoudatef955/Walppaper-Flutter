import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'database.dart';

class Authentication {
  FirebaseAuth _auth; //= FirebaseAuth.instance;
  GoogleSignIn googleSignIn; // = GoogleSignIn();
  Authentication() {
    Firebase.initializeApp().then((value) {
      _auth = FirebaseAuth.instance;
      googleSignIn = GoogleSignIn();
    });
  }

  Future<String> registerWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print('----create Account------');
      print(user.uid);
      DatabaseServivce(user.uid).updateUserData(userName);
      print('***create user $userName');
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
    
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print('----Signed In------');
      print(user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print("User Signed Out");
    debugPrint('User Signed Out');
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out Google");
    debugPrint('User Signed Out Google');
  }
}
