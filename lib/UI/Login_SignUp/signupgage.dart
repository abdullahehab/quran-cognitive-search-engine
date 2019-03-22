import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Tools/progress_dialog.dart';
import 'package:flutter_app/Tools/snackBar.dart';
import 'package:flutter_app/sevices/studentManagment.dart';
import 'package:flutter_app/sevices/teacherManagement.dart';

class SinhUp extends StatefulWidget {
  @override
  _SinhUpState createState() => _SinhUpState();
}

class _SinhUpState extends State<SinhUp> {

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final _emailText = TextEditingController();
  final _nameText = TextEditingController();
  final _passwordText = TextEditingController();
  final String _birthDate = null;
  bool _validate = false;

  @override
  void dispose() {
    _passwordText.dispose();
    _emailText.dispose();
    _nameText.dispose();
    super.dispose();
  }

  String _email, _password, _name;

  var _currencies = ['Student', 'Teacher'];
  var _currentItemSelected = 'Student';
  FirebaseUser currentUserLoggedIn;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();

  final separator = Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// To set white line
          Container(
            color: Colors.white,
            height: 1.5,
            width: 135.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "OR",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Sans",
                  fontSize: 20.0),
            ),
          ),

          /// To set white line
          Container(
            color: Colors.white,
            height: 1.2,
            width: 110.0,
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      key: _formKey,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 50.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 20.0),
                                                items: _currencies.map((String
                                                    dropDownStringItem) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: dropDownStringItem,
                                                    child: new Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 20.0),
                                                          child: new Icon(
                                                              Icons
                                                                  .account_circle,
                                                              size: 25.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        new Text(
                                                            dropDownStringItem),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (String newValueSelected) {
                                                  //your code to execute , when a menu item is selected from drop down
                                                  _onDropDownItemSelected(
                                                      newValueSelected);
                                                },
                                                value: _currentItemSelected,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            /* Name Text Form Filed */
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                              child: Container(
                                                height: 60.0,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    //color: Colors.white,
                                                    //boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: Colors.teal),
                                                        bottom: BorderSide(
                                                            color: Colors.teal),
                                                        right: BorderSide(
                                                            color: Colors.teal),
                                                        left: BorderSide(
                                                            color:
                                                                Colors.teal))),
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 30.0,
                                                    top: 0.0,
                                                    bottom: 0.0),
                                                child: Theme(
                                                  data: ThemeData(
                                                    hintColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    controller: _nameText,
                                                    onChanged: (String val) {
                                                      setState(() {
                                                        _name = val;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Enter Full Name',
                                                        errorText: _validate
                                                            ? 'Name Can\'t Be Empty'
                                                            : null,
                                                        icon: Icon(
                                                          Icons.account_circle,
                                                          color: Colors.white,
                                                        ),
                                                        labelStyle: TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Sans',
                                                            letterSpacing: 0.3,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 25.0,
                                            ),
                                            /* Email Text Form Filed */
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                              child: Container(
                                                height: 60.0,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    //color: Colors.white,
                                                    //boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: Colors.teal),
                                                        bottom: BorderSide(
                                                            color: Colors.teal),
                                                        right: BorderSide(
                                                            color: Colors.teal),
                                                        left: BorderSide(
                                                            color:
                                                                Colors.teal))),
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 30.0,
                                                    top: 0.0,
                                                    bottom: 0.0),
                                                child: Theme(
                                                  data: ThemeData(
                                                    hintColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    controller: _emailText,
                                                    onChanged: (String val) {
                                                      _email = val;
                                                    },
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Enter Email',
                                                        errorText: _validate
                                                            ? 'Email Can\'t Be Empty'
                                                            : null,
                                                        icon: Icon(
                                                          Icons.email,
                                                          color: Colors.white,
                                                        ),
                                                        labelStyle: TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Sans',
                                                            letterSpacing: 0.3,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 25.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                              child: Container(
                                                height: 60.0,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    //color: Colors.white,
                                                    //boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: Colors.teal),
                                                        bottom: BorderSide(
                                                            color: Colors.teal),
                                                        right: BorderSide(
                                                            color: Colors.teal),
                                                        left: BorderSide(
                                                            color:
                                                                Colors.teal))),
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 30.0,
                                                    top: 0.0,
                                                    bottom: 0.0),
                                                child: Theme(
                                                  data: ThemeData(
                                                    hintColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    controller: _passwordText,
                                                    onChanged: (String val) {
                                                      _password = val;
                                                    },
                                                    obscureText: _secureText,
                                                    decoration: InputDecoration(
                                                        suffixIcon: IconButton(
                                                          onPressed: showHide,
                                                          icon: Icon(_secureText ? Icons.visibility: Icons.visibility_off),
                                                        ),
                                                        errorText: _validate
                                                            ? 'Password Can\'t Be Empty'
                                                            : null,
                                                        labelText:
                                                            'Enter password',
                                                        icon: Icon(
                                                          Icons.vpn_key,
                                                          color: Colors.white,
                                                        ),
                                                        labelStyle: TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily: 'Sans',
                                                            letterSpacing: 0.3,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Container(
                                              alignment: Alignment(1.0, 0.0),
                                              padding: EdgeInsets.only(
                                                  top: 15.0, left: 10.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(30.0),
                                              child: new Container(
                                                  height: 55.0,
                                                  width: 600.0,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(color: Colors.black38, blurRadius: 15.0)
                                                      ],
                                                      gradient: LinearGradient(colors: [
                                                        Colors.teal[400],
                                                        Colors.teal[400]
                                                      ]),
                                                      borderRadius: BorderRadius.circular(30.0)),
                                                  child: FlatButton(
                                                    child: Text(
                                                      "Login",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "UbuntuBold"),
                                                    ),
                                                    onPressed: () {
                                                      if (_nameText.text == "" && _emailText.text == "" && _passwordText.text == "") {
                                                        showSnackBar("All Fileds is required!", _scafoldKey);
                                                        return;
                                                      }
                                                      if (_emailText.text == "" && _passwordText.text == "") {
                                                        showSnackBar("Email & Password Fileds is required!", _scafoldKey);
                                                        return;
                                                      }
                                                      if (_nameText.text == "" && _passwordText.text == "") {
                                                        showSnackBar("Name & Password Fileds is required!", _scafoldKey);
                                                        return;
                                                      }
                                                      if (_nameText.text == "" && _emailText.text == "") {
                                                        showSnackBar("Name & Email Fileds is required!", _scafoldKey);
                                                        return;
                                                      }
                                                      if (_nameText.text == "") {
                                                        showSnackBar("Name Cannot Be Empty!", _scafoldKey);
                                                        return;
                                                      }
                                                      if (_emailText.text == "") {
                                                        showSnackBar("Email Cannot Be Empty!", _scafoldKey);
                                                        return;
                                                      }
                                                      if (_passwordText.text == "") {
                                                        showSnackBar("Password Cannot Be Empty", _scafoldKey);
                                                        return;
                                                      }
                                                      displayProgressDialog(context);
                                                      signIn();
                                                    },
                                                  )),
                                            ),
                                            /*InkWell(
                                                child: ButtonBlackBottom(),
                                                onTap: () {
                                                  setState(() {
                                                    _nameText.text.isEmpty
                                                        ? _validate = true
                                                        : _validate = false;
                                                    _emailText.text.isEmpty
                                                        ? _validate = true
                                                        : _validate = false;
                                                    _passwordText.text.isEmpty
                                                        ? _validate = true
                                                        : _validate = false;
                                                  });
                                                  signIn();
                                                  //                        displayProgressDialog(context);
                                                }),*/
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
        ));
  }

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((signedInUser) {
        if (_currentItemSelected == 'Student') {
          StudentManagement().storeNewStudent(
              signedInUser, context, _name, _currentItemSelected, _birthDate);
        } else if (_currentItemSelected == 'Teacher') {
          TeacherManagement().storeNewTeacher(
              signedInUser, context, _name, _currentItemSelected);
        }
        //final List<DocumentSnapshot> documents = result.documents;
      }).catchError((e) {
        closeProgressDialog(context);
        showSnackBar(e.toString(), _scafoldKey);
        print(e);
      });
    }
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

/*  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((signedInUser) {
        if(_currentItemSelected == 'Student'){
          StudentManagement()
              .storeNewStudent(signedInUser, context, _name, _currentItemSelected);
        }else if(_currentItemSelected == 'Teacher') {
          TeacherManagement()
              .storeNewTeacher(signedInUser, context, _name, _currentItemSelected);
        }
      }).catchError((e) {
        print(e);
      });
    }
  }*/
}

///ButtonBlack class
class ButtonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        /*rgb(5, 206, 158)*/
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Colors.teal[400], Colors.teal[400]])),
      ),
    );
  }
}
//7teh hena

class textFromField extends StatelessWidget {
  bool password;
  String email;
  IconData icon;
  TextInputType inputType;

  textFromField({this.email, this.icon, this.inputType, this.password});

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
          child: TextField(
            onChanged: (String val) {
              email = val;
            },
            decoration: InputDecoration(
                labelText: 'Enter Email',
                icon: Icon(
                  Icons.email,
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

class textFromFieldpass extends StatelessWidget {
  String namee;
  IconData icon;
  TextInputType inputType;

  textFromFieldpass({
    this.namee,
    this.icon,
    this.inputType,
  });

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
            onSaved: (String val) {
              namee = val;
            },
            validator: (val) => val.isEmpty ? 'Email required' : null,
            decoration: InputDecoration(
                labelText: 'Enter Full Name',
                icon: Icon(
                  Icons.account_circle,
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

class textFromFieldtype extends StatelessWidget {
  String namee;
  IconData icon;
  TextInputType inputType;

  textFromFieldtype({
    this.namee,
    this.icon,
    this.inputType,
  });

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
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some password';
              }
            },
            decoration: InputDecoration(
                labelText: 'Enter password',
                icon: Icon(
                  Icons.vpn_key,
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