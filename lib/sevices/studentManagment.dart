import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';

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

  updateStudent(selectedDoc, newValues) {
    Firestore.instance
        .collection('students')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }
}
