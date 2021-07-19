import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FireBaseHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? mUser=FirebaseAuth.instance.currentUser;
  Future<void> addUser(String id,String name) {
    CollectionReference users = firestore.collection('users');
    return users.doc(id).set({
     'name':name,
     'id':id,
    }).then((value) {print('success');})
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> makeRoom(String code){
    CollectionReference rooms = firestore.collection('rooms');
    return rooms.doc(code).set({
      'admin':mUser!.uid,
      'code':code,
      'people':[],
    }).then((value) {print('success');})
        .catchError((error) => print("Failed to make room: $error"));;
  }
  Future<void> joinRoom(String code) async {
    DocumentReference room = firestore.collection('rooms').doc(code);
    DocumentSnapshot snapshot;
    List people=[];
    await room.get().then((value)  {
      snapshot = value;
      people=snapshot.get("people");
    });

    people.add(mUser!.uid);
    return room.update({
      'people':people,
    }).then((value) {print('success');})
        .catchError((error) => print("Failed to make room: $error"));;
  }

}