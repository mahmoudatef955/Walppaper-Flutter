import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServivce {
  final String uid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('usersData');

  DatabaseServivce(this.uid);

  Future updateUserData(String userName) async {
    return await userCollection.doc(uid).set({
      'userName': userName,
    });
  }

  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(uid).snapshots();
  }
}
