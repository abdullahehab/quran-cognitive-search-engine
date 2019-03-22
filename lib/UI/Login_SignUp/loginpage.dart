import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/progress_dialog.dart';
import 'package:flutter_app/Tools/snackBar.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:flutter_app/UI/Login_SignUp/signupgage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
//import 'package:firebase_auth/firebase_auth.dart';

/*Google provider*/
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
/*Facebook provider*/
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

/*Twitter provider*/
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class logInPage extends StatefulWidget {
  @override
  _logInPageState createState() => _logInPageState();
}

class _logInPageState extends State<logInPage> {
  String _email, _password;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  /* Google signIn*/
  // GoogleSignIn googleAuth = new GoogleSignIn();
  //GoogleSignIn googleAuth = new GoogleSignIn();

  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUserLoggedIn;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance; // No errors so far
  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await _googleSignIn.isSignedIn();
    if (isLoggedIn) {
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(currentUserId: prefs.getString('id'))),
      );*/
    }

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
                                  key: _keyForm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 50.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      /*
                                      * shape: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0),)),*/
                                      children: <Widget>[
                                        ListTile(
                                            trailing: OutlineButton(
                                                child: Text(
                                                  "Skip",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: 0.2,
                                                      fontFamily: "Sans",
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                  Radius.circular(20.0),
                                                )),
                                                borderSide: BorderSide(
                                                    color: Colors.teal[400],
                                                    style: BorderStyle.solid,
                                                    width: 3.0),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllQuran()));
                                                })),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        new TextField(
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                          controller: _emailText,
                                          onChanged: (String val) =>
                                              _email = val,
                                          maxLength: 30,
                                          decoration: new InputDecoration(
                                              labelText: "Enter Email",
                                              labelStyle:
                                                  TextStyle(color: Colors.teal),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 20.0, 20.0, 20.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              )),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        new TextField(
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                          controller: _passwordText,
                                          onChanged: (String val) =>
                                              _password = val,
                                          decoration: new InputDecoration(
                                              labelText: "Password",
                                              suffixIcon: IconButton(
                                                onPressed: showHide,
                                                icon: Icon(_secureText ? Icons.visibility: Icons.visibility_off),
                                              ),
                                              labelStyle:
                                                  TextStyle(color: Colors.teal),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 20.0, 20.0, 20.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              )),
                                          obscureText: _secureText,
                                        ),
                                        Container(
                                          alignment: Alignment(1.0, 0.0),
                                          padding: EdgeInsets.only(
                                              top: 15.0, left: 10.0),
                                          child: InkWell(
                                            child: Text(
                                              'Forgot Password',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
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
                                                  if ( _emailText.text == "" && _passwordText.text == "") {
                                                    showSnackBar("Email & Password required!", _scafoldKey);
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
                                                  logIn();
                                                },
                                              )),
                                        ),
                                        /*InkWell(
                                          child: ButtonBlackBottom(),
                                          onTap: () {
                                            if(emailController.text == "") {
                                              showSnackBar("Email Cannot Be Empty!", _scafoldKey);
                                              *//*
                                              * _scafoldKey*//*
                                            }
                                            *//*setState(() {
                                              _emailText.text.isEmpty
                                                  ? _validate = true
                                                  : _validate = false;
                                              _passwordText.text.isEmpty
                                                  ? _validate = true
                                                  : _validate = false;
                                            });*//*
                                            if (_keyForm.currentState.validate()){
                                              logIn();
                                            }
                                          },
                                        ),*/
                                        ListTile(
                                          leading:
                                              Text("Don't Have An Account?",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                          trailing: InkWell(
                                              child: Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SinhUp()));
                                              }),
                                        ),
                                        separator,
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        /*InkWell(
                                          child: buttonCustomFacebook(),
                                          onTap: () {
                                            if (_keyForm.currentState
                                                .validate()) {
                                              //facebookSignIn();
                                            }
                                          },
                                        ),*/
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        InkWell(
                                          child: buttonCustomGoogle(),
                                          onTap: () {
                                            if (_keyForm.currentState
                                                .validate()) {
                                              _testSignInWithGoogle().whenComplete(() {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
                                              });
                                              //  googleSignIn();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
      ],
    ));
  }

  /*Handle Firebase SignIn*/
  Future<void> logIn() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((FirebaseUser user) {
          print(user.displayName);
      closeProgressDialog(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
    }).catchError((e) {
      closeProgressDialog(context);
      showSnackBar(e.toString(), _scafoldKey);
      print(e);
    });
  }

  Future<String> _testSignInWithGoogle() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser != null) {
      // check if already sign up
      final QuerySnapshot result =
      await Firestore.instance.collection('users').where('id', isEqualTo: currentUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        //Navigator.push(context, MaterialPageRoute(builder: (context) => SinhUp()));
        Firestore.instance
            .collection('users')
            .document(currentUser.uid)
            .setData({'nickname': currentUser.displayName, 'email': currentUser.email, 'photoUrl': currentUser.photoUrl, 'id': currentUser.uid});

        // Write data to local
        currentUserLoggedIn = currentUser;
        await prefs.setString('id', currentUserLoggedIn.uid);
        await prefs.setString('nickname', currentUserLoggedIn.displayName);
        await prefs.setString('photoUrl', currentUserLoggedIn.photoUrl);
        await prefs.setString('email', currentUserLoggedIn.email);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        //print(documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        //print(documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
        await prefs.setString('email', documents[0]['email']);
        print(documents[0]['email']);
      }
      Toast.show('Sign in success', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
      this.setState(() {
        isLoading = false;
      });

    //  ProfilePage(currentUserId: currentUser.uid);
    }else {
      Toast.show('Sign in fail', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.red);
      this.setState(() {
        isLoading = false;
      });
    }
    print(user.displayName);
    assert(user.uid == currentUser.uid);
    return 'signInWithGoogle succeeded: $user';
  }

  /*Handle Google SignIn*/
  /*Future<void> googleSignIn() async {
    googleAuth.signIn().then((result) {
      result.authentication.then((googleKey) {
        FirebaseAuth.instance
            .signInWithGoogle(
            idToken: googleKey.idToken, accessToken: googleKey.accessToken)
            .then((signedInUser) {
          print('Singed in as ${signedInUser.displayName}');
          Navigator.push(context, MaterialPageRoute(builder: (context) => homepage(user: signedInUser)));
         // ProfilePage(user: signedInUser);
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }*/



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

/*Handle Twitter Login*/
  /* Future<void> loginWithTwitter() async {
    twitterLogin.authorize().then((result) {
      switch(result.status) {
        case TwitterLoginStatus.loggedIn:
          FirebaseAuth.instance.signInWithTwitter(
              authToken: result.session.token,
              authTokenSecret: result.session.secret
          ).then((signedInUser) {
            Navigator.of(context).pushReplacementNamed('/homepage');
          }).catchError((e) {
            print(e);
          });
          break;

        case TwitterLoginStatus.cancelledByUser:
          print('cancelled by user');
          break;

        case TwitterLoginStatus.error:
          print('error');
          break;
      }
    }).catchError((e) {
      print(e);
    });
  }*/
/* Handle firebase loigin*/
  /*Future<void> login() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((FirebaseUser user) {
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(e.toString()),
      ));
    });
  }
*/
}

///ButtonBlack class
class ButtonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Login",
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

///buttonCustomFacebook class
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

///buttonCustomGoogle class
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