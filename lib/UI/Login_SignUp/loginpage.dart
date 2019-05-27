import 'package:QCSE/Tools/const.dart';
import 'package:QCSE/Tools/progress_dialog.dart';
import 'package:QCSE/Tools/snackBar.dart';
import 'package:QCSE/UI/Login_SignUp/signupgage.dart';
import 'package:QCSE/UI/QuranWidgets.dart';
import 'package:QCSE/sevices/Shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
//import 'package:firebase_auth/firebase_auth.dart';

/*Google provider*/
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
/*Facebook provider*/
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

/*Twitter provider*/
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class logInPage extends StatefulWidget {
  @override
  _logInPageState createState() => _logInPageState();
}

class _logInPageState extends State<logInPage>
    with SingleTickerProviderStateMixin {
  String _email, _password;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPrefs shared = SharedPrefs();
//  SharedPreferences prefs = new

  /* Google signIn*/
  // GoogleSignIn googleAuth = new GoogleSignIn();
  //GoogleSignIn googleAuth = new GoogleSignIn();
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUserLoggedIn;

// Ana hna 3melt comment Gehad andelaziz 13/4/2019 4:39
  @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
  }*/

//  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance; // No errors so far
  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = false;
    });
  }

  /*Facebook signIn*/
  // FacebookLogin fbLogin = new FacebookLogin();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _passwordText.dispose();
    _emailText.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();

// Comment by Gehad Abdelaziz 18/4/2019

/*  final separator = Center(
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
  );*/

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
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
                                Transform(
                                  transform: Matrix4.translationValues(
                                      animation.value * width, 0.0, 0.0),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Form(
                                            key: _keyForm,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 50.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 45.0),
                                                    child: ListTile(
                                                        trailing: OutlineButton(
                                                            child: Text(
                                                              "Skip",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.2,
                                                                  fontFamily:
                                                                      "Sans",
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            shape:
                                                                OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                              Radius.circular(
                                                                  20.0),
                                                            )),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .teal[400],
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                width: 3.0),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              AllQuran()));
                                                            })),
                                                  ),
                                                  SizedBox(
                                                    height: 80.0,
                                                  ),
                                                  new TextField(
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    controller: _emailText,
                                                    onChanged: (String val) =>
                                                        _email = val,
                                                    maxLength: 30,
                                                    decoration:
                                                        new InputDecoration(
                                                      labelText: "Enter Email",
                                                      labelStyle: TextStyle(
                                                          color: Colors.teal),
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              20.0,
                                                              20.0,
                                                              20.0,
                                                              20.0),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  new TextField(
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    controller: _passwordText,
                                                    onChanged: (String val) =>
                                                        _password = val,
                                                    decoration:
                                                        new InputDecoration(
                                                            labelText:
                                                                "Password",
                                                            suffixIcon:
                                                                IconButton(
                                                              onPressed:
                                                                  showHide,
                                                              icon: Icon(
                                                                _secureText
                                                                    ? Icons
                                                                        .visibility
                                                                    : Icons
                                                                        .visibility_off,
                                                                color:
                                                                    Colors.teal,
                                                              ),
                                                            ),
                                                            labelStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .teal),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        20.0,
                                                                        20.0,
                                                                        20.0,
                                                                        20.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            )),
                                                    obscureText: _secureText,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment(1.0, 0.0),
                                                    padding: EdgeInsets.only(
                                                        top: 15.0, left: 10.0),
                                                    child: InkWell(
                                                      child: Text(
                                                        'Forgot Password',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Montserrat',
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              Colors.teal,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
                                                    child: Transform(
                                                      transform: Matrix4
                                                          .translationValues(
                                                              delayedAnimation
                                                                      .value *
                                                                  width,
                                                              0.0,
                                                              0.0),
                                                      child: new Container(
                                                          height: 55.0,
                                                          width: 600.0,
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black38,
                                                                    blurRadius:
                                                                        15.0)
                                                              ],
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    Colors.teal[
                                                                        400],
                                                                    Colors.teal[
                                                                        400]
                                                                  ]),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0)),
                                                          child: FlatButton(
                                                            child: Text(
                                                              "Login",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      22.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "UbuntuBold"),
                                                            ),
                                                            onPressed: () {
                                                              if (_emailText
                                                                          .text ==
                                                                      "" &&
                                                                  _passwordText
                                                                          .text ==
                                                                      "") {
                                                                showSnackBar(
                                                                    "Email & Password required!",
                                                                    _scafoldKey);
                                                                return;
                                                              }
                                                              if (_emailText
                                                                      .text ==
                                                                  "") {
                                                                showSnackBar(
                                                                    "Email Cannot Be Empty!",
                                                                    _scafoldKey);
                                                                return;
                                                              }
                                                              if (_passwordText
                                                                      .text ==
                                                                  "") {
                                                                showSnackBar(
                                                                    "Password Cannot Be Empty",
                                                                    _scafoldKey);
                                                                return;
                                                              }
                                                              displayProgressDialog(
                                                                  context, "Loading Insha'llah");
                                                              logIn();
                                                            },
                                                          )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Dont\'n have an account ?',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white70),
                                                      ),
                                                      SizedBox(width: 5.0),
                                                      InkWell(
                                                        onTap: () {
                                                          //Navigator.of(context).pushNamed('/signup');
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SinhUp()),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Sing Up',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.teal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Loading
                          ],
                        ),
                      )),
                ),
                Positioned(
                  child: isLoading
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(themeColor),
                            ),
                          ),
                          color: Colors.white.withOpacity(0.8),
                        )
                      : Container(),
                ),
              ],
            ),
          );
        });
  }

  /*Handle Firebase SignIn*/
  Future<void> logIn() async {
    prefs = await SharedPreferences.getInstance();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((FirebaseUser user) {
      SharedPrefs shared = SharedPrefs();
      Firestore.instance
          .collection('/students')
          .document(_email)
          .get()
          .then((DocumentSnapshot ds) {
        if (ds.data == null) {
          Firestore.instance
              .collection('/teacher')
              .document(_email)
              .get()
              .then((DocumentSnapshot teacherDate) {
            shared.saveUserData(
                user,
                teacherDate.data['name'],
                teacherDate.data['type'],
                teacherDate.data['birth'],
                teacherDate.data['education'],
                teacherDate.data['numberOfReading'],
                teacherDate.data['numberOfParts'],
                teacherDate.data['jobTitle'],
                teacherDate.data['photoUrl'],
                teacherDate.data['aboutMe'],
                teacherDate.data['gender'],
                teacherDate.data['igaza'],
                teacherDate.data['university']);
          });
        } else {
          shared.saveUserData(
              user,
              ds.data['name'],
              ds.data['type'],
              ds.data['birth'],
              ds.data['education'],
              ds.data['numberOfReading'],
              ds.data['numberOfParts'],
              ds.data['jobTitle'],
              ds.data['photoUrl'],
              ds.data['aboutMe'],
              ds.data['gender'],
              '',
              ds.data['university']);
        }
      }).catchError((e) {
        print(e);
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllQuran()));
    }).catchError((e) {
      closeProgressDialog(context);
      if (e.toString().contains("ERROR_USER_NOT_FOUND")) {
        showSnackBar("User Not Found", _scafoldKey);
      } else if (e.toString().contains("ERROR_WRONG_PASSWORD")) {
        showSnackBar("The password is invalid", _scafoldKey);
      }else if (e.toString().contains("ERROR_INVALID_EMAIL")) {
        showSnackBar("The email address is badly formatted", _scafoldKey);
      }else if (e.toString().contains("ERROR_NETWORK_REQUEST_FAILED")) {
        showSnackBar("Network error", _scafoldKey);
      } else {
        showSnackBar(e.toString(), _scafoldKey);
        print(e);
      }
    });
  }

//  Future<String> _testSignInWithGoogle() async {
//    prefs = await SharedPreferences.getInstance();
//
//    this.setState(() {
//      isLoading = true;
//    });
//
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//    final FirebaseUser user = await _auth.signInWithCredential(credential);
//    assert(user.email != null);
//    assert(user.displayName != null);
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//    if (currentUser != null) {
//      // check if already sign up
//      final QuerySnapshot result = await Firestore.instance
//          .collection('users')
//          .where('id', isEqualTo: currentUser.uid)
//          .getDocuments();
//      final List<DocumentSnapshot> documents = result.documents;
//      if (documents.length == 0) {
//        // Update data to server if new user
//        //Navigator.push(context, MaterialPageRoute(builder: (context) => SinhUp()));
//        Firestore.instance
//            .collection('users')
//            .document(currentUser.uid)
//            .setData({
//          'nickname': currentUser.displayName,
//          'email': currentUser.email,
//          'photoUrl': currentUser.photoUrl,
//          'id': currentUser.uid
//        });
//
//        // Write data to local
//        SharedPrefs s = SharedPrefs();
//        s.saveUserData(
//            currentUser, "", "", "", "", "", "", "", "", "", "", "", "");
//        print(currentUser.displayName);
//        print(currentUser.email);
//        print(currentUser.photoUrl);
//      } else {
//        // Write data to local
//        await prefs.setString('id', documents[0]['id']);
//        await prefs.setString('nickname', documents[0]['nickname']);
//        //print(documents[0]['nickname']);
//        await prefs.setString('photoUrl', documents[0]['photoUrl']);
//        //print(documents[0]['photoUrl']);
//        await prefs.setString('aboutMe', documents[0]['aboutMe']);
//        await prefs.setString('email', documents[0]['email']);
//        print(documents[0]['email']);
//      }
//      Toast.show('Sign in success', context,
//          duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
//      this.setState(() {
//        isLoading = false;
//      });
//
//      //  ProfilePage(currentUserId: currentUser.uid);
//    } else {
//      Toast.show('Sign in fail', context,
//          duration: Toast.LENGTH_LONG, backgroundColor: Colors.red);
//      this.setState(() {
//        isLoading = false;
//      });
//    }
//    print(user.displayName);
//    assert(user.uid == currentUser.uid);
//    return 'signInWithGoogle succeeded: $user';
//  }

/*Handle facebook ligIn*/
  /*Future<void> facebookSignIn() async {
    fbLogin
        .logInWithReadPermissions(['email', 'public_profile']).then((result) {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          FirebaseAuth.instance
              .signInWithFacebook(accessToken: result.accessToken.token)
              .then((signedInUser) {
            print("Signed Is as ${signedInUser.displayName}");
            Navigator.push(context, MaterialPageRoute(builder: (context) => homepage(user: signedInUser)));
         //   ProfilePage(user: signedInUser);
          }).catchError((e) {
            print(e);
          });
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("calcelled by uer");
          break;
        case FacebookLoginStatus.error :
          print('error');
          break;
      }
    }).catchError((e) {
      print(e);
    });
  }*/

}

///buttonCustomGoogle class
/*
class buttonCustomGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/google.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Google",
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            )
          ],
        ),
      ),
    );
  }
}
*/

///buttonCustomFacebook class
/*
class buttonCustomFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(107, 112, 248, 1.0),
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15.0)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/icon_facebook.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Facebook",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
