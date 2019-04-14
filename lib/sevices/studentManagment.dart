import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class StudentManagement {

  /*
  * _birthDate, education, numOfReading, numOfParts*/
  storeNewStudent(user, context, name, currentItemSelected, _birthDate, education, numOfReading, numOfParts) {
     Firestore.instance.collection('/students').add({
      'uid': user.uid,
      'name': name,
      'email': user.email,
      'type': currentItemSelected,
      'birth': _birthDate,
      'education' : education,
      'numberOfReading' : numOfReading,
      'numberOfParts' : numOfParts
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllQuran()));
      // ProfilePage(user: user);
    }).catchError((e) {
      print(e);
    });
  }

  getAllStudent() async {
    return await Firestore.instance.collection('students').snapshots();
  }
  SharedPreferences prefs;
  updateStudent(selectedDoc, String name, String email, context) {
    Firestore.instance
        .collection('students')
        .document(selectedDoc)
        .updateData({'name': name, 'email': email}).then((data) async {
      print(name);
      print(email);
      prefs.setString('nickname', name);
      prefs.setString('email', email);

      Toast.show('Update success', context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
        //.catchError((e) {
      //print(e);
    }).catchError((e) {
      print(e);
    });
  }
}
