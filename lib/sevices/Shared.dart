import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

SharedPreferences prefs;

class SharedPrefs {
  Future<void> saveUserData(
      user,
      name,
      currentItemSelected,
      birthdate,
      education,
      numOfReading,
      numOfParts,
      jobTitle,
      photoUrl,
      aboutMe,
      gender,
      igaza,
      university) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('nickname', name);
    prefs.setString('email', user.email);
    prefs.setString('photoUrl', photoUrl);
    prefs.setString(
        "userType", currentItemSelected == null ? null : currentItemSelected);
    prefs.setString('birthdate', birthdate == null ? null : birthdate);
    prefs.setString('education', education == null ? null : education);
    prefs.setString('numOfReading', numOfReading == null ? null : numOfReading);
    prefs.setString('numOfParts', numOfParts == null ? 0 : numOfParts);
    prefs.setString('jobTitle', jobTitle == null ? 0 : jobTitle);
    prefs.setString('userType', currentItemSelected);
    prefs.setString('aboutMe', aboutMe);
    prefs.setString('gender', gender);
    prefs.setString('igaza', igaza);
    prefs.setString('university', university);
  }
}
