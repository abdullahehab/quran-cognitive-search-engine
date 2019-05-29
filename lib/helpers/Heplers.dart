import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class Helper {

  isLoggedIn() {
    if (_auth.currentUser() != null) {
      print(_auth.currentUser());
      print('exits user');
      return true;
    }else
      print('no user');
      print(_auth.currentUser());
      return false;
  }



}