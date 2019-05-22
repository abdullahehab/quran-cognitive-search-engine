import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class Helper {

  isLoggedIn() {
    if (_auth.currentUser() == null) {
      return true;
    }else
      return false;
  }
}