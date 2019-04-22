import 'package:flutter/material.dart';
import 'package:flutter_app/UI/Login_SignUp/loginpage.dart';
import 'package:flutter_app/UI/Login_SignUp/signupgage.dart';
import 'package:flutter_app/UI/Pages/WatsonChatBot.dart';
import 'package:flutter_app/UI/Pages/allStudent.dart';
import 'package:flutter_app/UI/Pages/allTeacher.dart';
import 'package:flutter_app/UI/Pages/editProfile.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:flutter_app/UI/SplashScreen.dart';

void main() => runApp(MaterialApp(
  home: logInPage(),
  //home: AllQuran(),
  //home: EditProfile(),
  debugShowCheckedModeBanner: false,
));
