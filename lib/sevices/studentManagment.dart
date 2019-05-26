import 'package:QCSE/UI/QuranWidgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class StudentManagement {
  createNewStudent(
      user,
      context,
      name,
      email,
      currentItemSelected,
      _birthDate,
      education,
      numOfReading,
      numOfParts,
      jobTitle,
      photoUrl,
      aboutMe,
      gender,
      university) {
    DocumentReference ds =
        Firestore.instance.collection('/students').document(email);
    Map<String, dynamic> user = {
      'name': name,
      'type': currentItemSelected,
      'birth': _birthDate,
      'education': education,
      'numberOfReading': numOfReading,
      'numberOfParts': numOfParts,
      'jobTitle': jobTitle,
      'photoUrl': photoUrl,
      'aboutMe': aboutMe,
      'gender': gender,
      'university': university
    };
    ds.setData(user).whenComplete(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllQuran()));
      print('user created');
      Toast.show('welcome $name', context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
    });
  }

  //SharedPreferences prefs;
  updateStudentData(context, name, email, jobTitle, numOfReading, numOfParts,
      education, birthDate, photoUrl, aboutMe, gender, university) {
    DocumentReference ds =
        Firestore.instance.collection('/students').document(email);
    Map<String, dynamic> user = {
      'name': name,
      'email': email,
      'jobTitle': jobTitle,
      'numberOfReading': numOfReading,
      'numberOfParts': numOfParts,
      'education': education,
      'birth': birthDate,
      'photoUrl': photoUrl,
      'aboutMe': aboutMe,
      'gender': gender,
      'university': university
    };
    ds.updateData(user).whenComplete(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllQuran()));
      Toast.show('user $name profile updated done', context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
    }).catchError((e) {
      print(e);
    });
  }

  getAllStudent() async {
    return await Firestore.instance.collection('/students').getDocuments();
  }
}
