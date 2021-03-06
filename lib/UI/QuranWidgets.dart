import 'package:QCSE/UI/Login_SignUp/loginpage.dart';
import 'package:QCSE/UI/Pages/WatsonChatBot.dart';
import 'package:QCSE/UI/Pages/allStudent.dart';
import 'package:QCSE/UI/Pages/allTeacher.dart';
import 'package:QCSE/UI/Pages/profilePage.dart';
import 'package:QCSE/UI/Pages/voiceSearch.dart';
import 'package:QCSE/helpers/Heplers.dart';
import 'package:QCSE/quranList.dart';
import 'package:QCSE/sevices/QuranBookMark.dart';
import 'package:QCSE/speed%20radial/speed_dial.dart';
import 'package:QCSE/speed%20radial/speed_dial_child.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllQuran extends StatefulWidget {
  @override
  _AllQuranState createState() => _AllQuranState();
}

class _AllQuranState extends State<AllQuran> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> gKey = new GlobalKey<ScaffoldState>();

  bool loggedIn = false;
  bool test = true;
  int pageNumber = 0;
  int bookMark;
  String name, part;
  SharedPreferences prefs;
//  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    pageNumberFunction(pageNumber);
//    readLocal();
  }

  void readLocal() async {
    bookMark = prefs.getInt('quranPage');
    print(bookMark);
    print('read local');
//    print(bookMark);
  }

  // Speed Radial //
  bool _iconVisibility = true;

  void _visibilityMethod() {
    setState(() {
      if (_iconVisibility) {
        _iconVisibility = false;
      } else {
        _iconVisibility = true;
      }
    });
  }
  // End Speed Radial

  String partName(int pageNumber) {
    if (0 < pageNumber && pageNumber < 10) {
      setState(() {
        part = "الجزء الاول";
      });
    }
    if (pageNumber > 10) {
      setState(() {
        part = "الجزء الثاني";
      });
    }
    return part;
  }

  String getSurahName(int pageNumber) {
    if (0 < pageNumber && pageNumber < 10) {
      setState(() {
        name = "البقره";
      });
    }
    if (pageNumber > 10) {
      setState(() {
        name = "ال عمران";
      });
    }
    return name;
  }

  int pageNumberFunction(int num) {
    setState(() {
      pageNumber = num + 1;
      getSurahName(pageNumber);
      partName(pageNumber);
    });
    return pageNumber;
  }

  @override
  void setState(fn) {
    //pageNumberFunction();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(top: 19.0),
              child: new DefaultTabController(
                  length: quran_imgs.length,
                  child: PageView.builder(
                    itemCount: quran_imgs.length,
                    onPageChanged: pageNumberFunction,
                    controller: PageController(
                        initialPage: bookMark == null ? 0 : bookMark,
                        keepPage: true),
                    reverse: true,
                    itemBuilder: (context, index) {
//                        pageNumberFunction(index);

                      try {
                        return Image.asset(
                          'assets/quran/' + quran_imgs[index],
                          fit: BoxFit.fill,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                  )),
            ),
            onTap: () {
              print('taped');
              _visibilityMethod();
            },
          ),
//            color: Colors.black.withOpacity(0.7),
          /* Edit By Gehad Adelaziz 4/3/2019 1:20 pm*/
//            Column(
//              children: <Widget>[
//                // Edit By Gehad Adelaziz 13/4/2019 3:14 pm
//                Container(
//                  color: Colors.black.withOpacity(0.7),
//                  child: ListTile(
//                    leading: Text(
//                      " $name ",
//                      style: TextStyle(color: Colors.white, fontSize: 20.0),
//                    ),
//                    title: Center(
//                        child: Text(
//                      "$pageNumber",
//                      style: TextStyle(color: Colors.white, fontSize: 20.0),
//                    )),
//                    trailing: Text(
//                      "$part",
//                      style: TextStyle(color: Colors.white, fontSize: 20.0),
//                    ),
//                  ),
//                ),
//              ],
//            ),
        ],
      ),
//      _iconVisibility
      floatingActionButton: SpeedDial(
        // both default to 16
        visible: _iconVisibility,
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetAllTeacher()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'All Teachers',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetAllStudent()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'All Students',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.assignment_ind),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'Profile',
            //    labelStyle: TextTheme(fontSize: 18.0),su
            onTap: () {},
          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.chat),
              onTap: () {
//                help.loggedin();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WatsonChat()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'Chat-Bot',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
//          SpeedDialChild(
//            child: Icon(Icons.bookmark),
//            backgroundColor: Colors.green,
//            label: 'Book-Mark',
//            //    labelStyle: TextTheme(fontSize: 18.0),
//            onTap: () => print('THIRD CHILD'),
//          ),
//          SpeedDialChild(
//            child: Icon(Icons.bookmark_border),
//            backgroundColor: Colors.green,
//            label: 'Return-book',
//            //    labelStyle: TextTheme(fontSize: 18.0),
//            onTap: () => print('THIRD CHILD'),
//          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.exit_to_app),
              onTap: () {
                signOutWithGoogle();
                print('res');
              },
            ),
            backgroundColor: Colors.green,
            label: 'LogOut',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.keyboard_voice),
              onTap: () {
                print('voidce');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VoiceSearch()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'Voice Search',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }

  Future<void> signOutWithGoogle() async {
//    await _auth.signOut();
    FirebaseAuth.instance.signOut().then((_) {
      print('success logging out');
    }).catchError((e) {
      print('failure logging out');
      print(e);
    });
    return await FirebaseAuth.instance.signOut();
//    Helper().isLoggedIn();
  }

/*  Future<void> handleSignOut() async {
    FirebaseAuth.instance.signOut();
    FirebaseUser user = FirebaseAuth.instance.currentUser();
    print(user);
    await _auth.signOut();
    await googleSignIn.signOut();
    if(user == null) {
      Toast.show('Sign Out success', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }else {
      Toast.show('Faild to Sign Out', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.red);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
    }
    }*/
}
