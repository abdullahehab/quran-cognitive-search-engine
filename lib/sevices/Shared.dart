import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

SharedPreferences prefs;

class SharedPrefs {
  Future<void> saveUserData(user, name, currentItemSelected, birthdate, education, numOfReading, numOfParts) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.uid);
    prefs.setString(
        'nickname', user.displayName == null ? name : user.displayName);
    print(user.displayName);
    print(name);
    prefs.setString('email', user.email);
    print(user.email);
    prefs.setString('photourl', user.photoUrl);
    prefs.setString("userType", currentItemSelected == null ? null : currentItemSelected);
    prefs.setString('birthdate', birthdate == null ? null : birthdate);
    prefs.setString('education', education == null ? null : education);
    prefs.setInt('numOfReading', numOfReading == null ? null : numOfReading);
    prefs.setInt('numOfParts', numOfParts == null ? null : numOfParts);
  }
}
