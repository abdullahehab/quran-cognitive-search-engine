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
    prefs.setString('id', user.uid);
    prefs.setString(
        'nickname', user.displayName == null ? name : user.displayName);
    print(user.displayName);
    print(name);
    prefs.setString('email', user.email);
    print(user.email);
    prefs.setString(
        'photourl',
        user.photoUrl == null
            ? photoUrl == null ? null : photoUrl
            : user.photoUrl);
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
