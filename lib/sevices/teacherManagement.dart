import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';

class TeacherManagement {
  storeNewTeacher(user, context, name, currentItemSelected) {
    Firestore.instance.collection('/teacher').add({
      'uid' : user.uid,
      'name' : name,
      'email': user.email,
      'type' : currentItemSelected
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
    }).catchError((e) {
      print(e);
    });
  }

  getAllTeacher() async {
    return await Firestore.instance.collection('teacher').getDocuments();
  }
}
