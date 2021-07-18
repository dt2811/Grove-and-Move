import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FireBaseHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(String id,String name) {
    CollectionReference users = firestore.collection('users');
    return users.doc(id).set({
     'name':name,
     'id':id,
    }).then((value) {print('success');})
        .catchError((error) => print("Failed to add user: $error"));
  }

}