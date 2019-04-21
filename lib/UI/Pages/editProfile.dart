import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/const.dart';
import 'package:flutter_app/Tools/snackBar.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/sevices/studentManagment.dart';
import 'package:flutter_app/sevices/teacherManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}
StudentManagement s = new StudentManagement();
class _EditProfileState extends State<EditProfile> {
  DateTime selectedDate = DateTime.now();

  StudentManagement student = StudentManagement();
  TeacherManagement teacher = TeacherManagement();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
    }
    uploadFile();
  }

  Future uploadFile() async {
    String fileName = email;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(avatarImageFile);
    StorageTaskSnapshot storageTaskSnapshot;
    uploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          photoUrl = downloadUrl;
          if (userType == 'Student') {
            student.updateStudentData(context, _nameController.text, email, _jobTitleController.text, _numOfReadingController.text, _numOfPartsController.text, _educationController.text, birthDate, photoUrl, _aboutMeController, gender, university);
            prefs.setString('photoUrl', photoUrl);
            readLocal();
          } else if (userType == 'Teacher') {
            teacher.updateTeacherData(context, _nameController.text, email, _jobTitleController.text, _numOfReadingController.text, _numOfPartsController.text, _educationController.text, birthDate, photoUrl, _aboutMeController, gender, igaza, university);
            prefs.setString('photoUrl', photoUrl);
            readLocal();
          }
          }, onError: (err) {
          setState(() {
            isLoading = false;
          });
          Toast.show('This file is not an image', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
          });
      } else {
        setState(() {
          isLoading = false;
        });
        Toast.show('This file is not an image', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
       }
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Toast.show(err.toString(), context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
      });
  }


  SharedPreferences prefs;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';
  String email = '';
  String type = '';
  String birthDate ;
  String stuEducation = '';
  String jobTitle = '';
  String numOfReading = '' ;
  String numOfParts = '';
  String userType = '';
  String gender = '';
  String igaza = '';
  String university = '';

  File avatarImageFile;
  bool isLoading = false;

  TextEditingController _nameController;
  TextEditingController _jobTitleController;
  TextEditingController _numOfReadingController;
  TextEditingController _numOfPartsController;
  TextEditingController _educationController;
  TextEditingController _aboutMeController;
  TextEditingController _universityController;

  final FocusNode focusNodeName = new FocusNode();
  final FocusNode focusNodeJobTitle = new FocusNode();
  final FocusNode focusNodeNumOfReading = new FocusNode();
  final FocusNode focusNodenumOfParts = new FocusNode();
  final FocusNode focusNodeEducation = new FocusNode();
  final FocusNode focusNodeAboutMe = new FocusNode();
  final FocusNode focusNodeUniversity = new FocusNode();

  final nameIcon = Icons.person_pin;
  final emailIcon = Icons.email;
  final numOfReadingIcon = Icons.bookmark;
  final numOfPartIcons = Icons.person_outline;
  final educationIcon = Icons.school;
  final icon = Icons.work;
  final aboutMeIcon = Icons.info;
  final universityIcon = Icons.school;

  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    print(id);
    nickname = prefs.getString('nickname');
    photoUrl = prefs.getString('photoUrl');
    email = prefs.getString('email');
    aboutMe = prefs.getString('aboutMe');
    type = prefs.getString('userType');
    stuEducation = prefs.getString('education');
    numOfReading = prefs.getString('numOfReading');
    numOfParts = prefs.getString('numOfParts');
    jobTitle = prefs.getString('jobTitle');
    birthDate = prefs.getString('birthdate');
    userType = prefs.getString('userType');
    gender = prefs.getString('gender');
    igaza = prefs.getString('igaza');
    university = prefs.getString('university');

    _nameController = new TextEditingController(text: nickname);
    _jobTitleController = new TextEditingController(text: jobTitle);
    _numOfReadingController = new TextEditingController(text: numOfReading);
    _numOfPartsController = new TextEditingController(text: numOfParts);
    _educationController = new TextEditingController(text: stuEducation);
    _aboutMeController = new TextEditingController(text: aboutMe);
    birthDate = selectedDate.year.toString();
    _universityController = new TextEditingController(text: university);
    /*_currentItemSelectedGender = gender == '' ? 'male' : gender;
    _currentItemSelected = igaza == '' ? 'لا' : igaza ;
    */// Force refresh input
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _numOfReadingController.dispose();
    _numOfPartsController.dispose();
    _educationController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }


  var _currencies = ['نعم', 'لا'];
  var _currentItemSelected = 'لا';
  var _currenciesGender = ['male', 'female'];
  var _currentItemSelectedGender = 'male';


  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scafoldKey,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/test.jpeg',
                        ),
                        fit: BoxFit.fill)),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.0),
                        Color.fromRGBO(0, 0, 0, 0.3)
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                    )),
                    child: SingleChildScrollView(
                      child: Stack(
                        //alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                //alignment: AlignmentDirectional.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Form(
                                        key: _keyForm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 16.0),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Center(
                                                  child: Stack(
                                                    children: <Widget>[
                                                      (avatarImageFile == null)
                                                          ? (photoUrl != ''
                                                          ? Material(
                                                        child: CachedNetworkImage(
                                                          placeholder: (context, url) => Container(
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2.0,
                                                              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                                                            ),
                                                            width: 90.0,
                                                            height: 90.0,
                                                            padding: EdgeInsets.all(20.0),
                                                          ),
                                                          imageUrl: photoUrl,
                                                          width: 90.0,
                                                          height: 90.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                                                        clipBehavior: Clip.hardEdge,
                                                      )
                                                          : Icon(
                                                        Icons.account_circle,
                                                        size: 90.0,
                                                        color: greyColor,
                                                      )
                                                      )
                                                          : Material(
                                                        child: Image.file(
                                                          avatarImageFile,
                                                          width: 90.0,
                                                          height: 90.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                                                        clipBehavior: Clip.hardEdge,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.camera_alt,
                                                          color: primaryColor.withOpacity(0.5),
                                                        ),
                                                        onPressed: getImage,
                                                        padding: EdgeInsets.all(30.0),
                                                        splashColor: Colors.transparent,
                                                        highlightColor: greyColor,
                                                        iconSize: 30.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                width: double.infinity,
                                                margin: EdgeInsets.all(20.0),
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              //Name Text Form Filed
                                              TextFromField(
                                                  'Enter your Name',
                                                  nameIcon,
                                                  TextInputType.text,
                                                  _nameController,
                                                  nickname,
                                                focusNodeName
                                                  ),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              TextFromField(
                                                  'job title',
                                                  icon,
                                                  TextInputType.text,
                                                  _jobTitleController,
                                                  jobTitle,
                                              focusNodeJobTitle),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              // Number OF Reading Text For Filed
                                              TextFromField(
                                                  'Number Of Reading',
                                                  numOfReadingIcon,
                                                  TextInputType.number,
                                                  _numOfReadingController,
                                                  numOfReading,
                                              focusNodeNumOfReading),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              // Number OF Parts Text Form Field
                                              TextFromField(
                                                  'Number Of Parts',
                                                  numOfPartIcons,
                                                  TextInputType.number,
                                                  _numOfPartsController,
                                                  numOfParts,
                                              focusNodenumOfParts),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              TextFromField(
                                                  'University',
                                                  universityIcon,
                                                  TextInputType.text,
                                                  _universityController,
                                                  university,
                                                  focusNodeUniversity),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              // Education Text Form Field
                                              TextFromField(
                                                  'Department',
                                                  educationIcon,
                                                  TextInputType.text,
                                                  _educationController,
                                                  stuEducation,
                                              focusNodeEducation),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              TextFromField(
                                                  'About Me',
                                                  aboutMeIcon,
                                                  TextInputType.text,
                                                  _aboutMeController,
                                                  aboutMe,
                                                  focusNodeAboutMe),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              ListTile(
                                                title: Text(
                                                  birthDate ?? 'test',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                leading: RaisedButton(
                                                  color: Colors.transparent,
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.teal),
                                                  ),
                                                  onPressed: () =>
                                                      _selectDate(context),
                                                  child: Text(
                                                    'Birthday',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              userType == 'Teacher' ?
                                              ListTile(
                                                title:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    items: _currencies.map(
                                                        (String
                                                            dropDownStringItem) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            dropDownStringItem,
                                                        child: new Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          30.0),
                                                            ),
                                                            new Text(
                                                                dropDownStringItem),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String
                                                        newValueSelected) {
                                                      //your code to execute , when a menu item is selected from drop down
                                                      _onDropDownItemSelected(
                                                          newValueSelected);
                                                    },
                                                    value: _currentItemSelected,
                                                  ),
                                                ),
                                                leading: RaisedButton(
                                                  color: Colors.transparent,
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.teal),
                                                  ),
                                                  onPressed: () => {},
                                                  child: Text(
                                                    ' ايجازه ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                                  : Container(),
                                              ListTile(
                                                title:
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                    items: _currenciesGender.map(
                                                            (String
                                                        dropDownStringItem) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value:
                                                            dropDownStringItem,
                                                            child: new Row(
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      30.0),
                                                                ),
                                                                new Text(
                                                                    dropDownStringItem),
                                                              ],
                                                            ),
                                                          );
                                                        }).toList(),
                                                    onChanged: (String
                                                    newValueSelected) {
                                                      //your code to execute , when a menu item is selected from drop down
                                                      _onDropDownItemSelectedGender(
                                                          newValueSelected);
                                                    },
                                                    value: _currentItemSelectedGender,
                                                  ),
                                                ),
                                                leading: RaisedButton(
                                                  color: Colors.transparent,
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.teal),
                                                  ),
                                                  onPressed: () => {},
                                                  child: Text(
                                                    ' Gender ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10.0,),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30.0, left: 30.0),
                                                child: new Container(
                                                    height: 55.0,
                                                    width: 600.0,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black38,
                                                              blurRadius: 15.0)
                                                        ],
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Colors.teal[400],
                                                              Colors.teal[400]
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30.0)),
                                                    child: FlatButton(
                                                      child: Text(
                                                        "Update",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "UbuntuBold"),
                                                      ),
                                                      onPressed: () {
                                                          if ( userType == 'Student') {
                                                            student.updateStudentData(context, _nameController.text, email, _jobTitleController.text, _numOfReadingController.text, _numOfPartsController.text, _educationController.text, birthDate, photoUrl, _aboutMeController.text, _currentItemSelectedGender, _universityController.text);
                                                            prefs.setString('nickname', _nameController.text);
                                                            prefs.setString('jobTitle', _jobTitleController.text);
                                                            prefs.setString('numOfReading', _numOfReadingController.text);
                                                            prefs.setString('numOfParts', _numOfPartsController.text);
                                                            prefs.setString('education', _educationController.text);
                                                            prefs.setString('photoUrl', photoUrl);
                                                            prefs.setString('birthdate', birthDate);
                                                            prefs.setString('aboutMe', _aboutMeController.text);
                                                            prefs.setString('gender', _currentItemSelectedGender);
                                                            prefs.setString('university', _universityController.text);
                                                            readLocal();
                                                          } else if (userType == 'Teacher') {
                                                            teacher.updateTeacherData(context, _nameController.text, email, _jobTitleController.text, _numOfReadingController.text, _numOfPartsController.text, _educationController.text, birthDate, photoUrl, _aboutMeController.text, _currentItemSelectedGender, _currentItemSelected, _universityController.text);
                                                            prefs.setString('nickname', _nameController.text);
                                                            prefs.setString('jobTitle', _jobTitleController.text);
                                                            prefs.setString('numOfReading', _numOfReadingController.text);
                                                            prefs.setString('numOfParts', _numOfPartsController.text);
                                                            prefs.setString('education', _educationController.text);
                                                            prefs.setString('photoUrl', photoUrl);
                                                            prefs.setString('birthdate', birthDate);
                                                            prefs.setString('aboutMe', _aboutMeController.text);
                                                            prefs.setString('gender', _currentItemSelectedGender);
                                                            prefs.setString('igaza', _currentItemSelected);
                                                            prefs.setString('university', _universityController.text);
                                                            readLocal();
                                                          }
                                                        //print(_emailText);
                                                        /* if (nameController.text == "" ||
    emailController.text == "" ||
    jobController.text == "" ||
    numOfReadingController.text == "" ||
    numOfPartsController.text == "" ||
    educationController.text == "") {
    showSnackBar("All Fields required", _scafoldKey);
    return;
    }*/
                                                      },
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  void _onDropDownItemSelectedGender(String newValueSelected) {
    setState(() {
      this._currentItemSelectedGender = newValueSelected;
    });
  }
}

///ButtonBlack class
class GeneralButton extends StatelessWidget {
  TextEditingController nameController,
      jobController,
      numOfReadingController,
      numOfPartsController,
      educationController,
      emailController;
  GlobalKey<ScaffoldState> _scafoldKey;

  GeneralButton(
      this.nameController,
      this.jobController,
      this.numOfReadingController,
      this.numOfPartsController,
      this.educationController,
      this.emailController,
      this._scafoldKey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0, left: 30.0),
      child: new Container(
          height: 55.0,
          width: 600.0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
              gradient:
                  LinearGradient(colors: [Colors.teal[400], Colors.teal[400]]),
              borderRadius: BorderRadius.circular(30.0)),
          child: FlatButton(
            child: Text(
              "Update",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "UbuntuBold"),
            ),
            onPressed: () {
              if (nameController.text == "" ||
                  emailController.text == "" ||
                  jobController.text == "" ||
                  numOfReadingController.text == "" ||
                  numOfPartsController.text == "" ||
                  educationController.text == "") {
                showSnackBar("All Fields required", _scafoldKey);
                return;
              }
              //         handleUdpateData();
              print(nameController.text);
            },
          )),
    );
  }
}

class TextFromField extends StatelessWidget {
  TextFromField(this.name, this.icon, this.inputType, this.controller,
      this.inputValue, this.focusNode);

  String name;
  IconData icon;
  TextInputType inputType;
  TextEditingController controller;
  var inputValue;
  FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            //color: Colors.white,
            //boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]
            border: Border(
                top: BorderSide(color: Colors.teal),
                bottom: BorderSide(color: Colors.teal),
                right: BorderSide(color: Colors.teal),
                left: BorderSide(color: Colors.teal))),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            onSaved: (val) {
              inputValue = val;
            },
            controller: controller,
            decoration: InputDecoration(
                labelText: name,
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}
