import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class Helper {

  loggedin() {
    if (_auth.currentUser() == null) {
      print('no user');
    }else
      print ('user here');
  }
}