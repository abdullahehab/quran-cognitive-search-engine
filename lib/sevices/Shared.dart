import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

SharedPreferences prefs;

class SharedPrefs {
  Future<void> saveUserData(user, name, currentItemSelected, birthdate) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.uid);
    prefs.setString(
        'nickname', user.displayName == null ? name : user.displayName);
    prefs.setString('email', user.email);
    prefs.setString('photourl', user.photoUrl);
    prefs.setString("userType", currentItemSelected == null ? null : currentItemSelected);
    prefs.setString('birthdate', birthdate == null ? null : birthdate);
  }
}
