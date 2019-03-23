import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/Pages/allStudent.dart';
import 'package:flutter_app/UI/Pages/allTeacher.dart';
import 'package:flutter_app/UI/Pages/profilePage.dart';
import 'package:flutter_app/quranList.dart';
import 'package:flutter_app/sevices/studentManagment.dart';
import 'package:flutter_app/sevices/teacherManagement.dart';
import 'package:flutter_app/speed%20radial/speed_dial.dart';
import 'package:flutter_app/speed%20radial/speed_dial_child.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class AllQuran extends StatefulWidget {
  @override
  _AllQuranState createState() => _AllQuranState();
}

class _AllQuranState extends State<AllQuran> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> gKey = new GlobalKey<ScaffoldState>();

  int pageNumber = 9;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  // Speed Radial //
  bool _iconVisibility = true;

  void _visibilitymethod() {
    setState(() {
      if (_iconVisibility) {
        _iconVisibility = false;
      } else {
        _iconVisibility = true;
      }
    });
  }
  // End Speed Radial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(top: 19.0),
          child: new DefaultTabController(
              length: quran_imgs.length,
              child: PageView.builder(
               // physics: new NeverScrollableScrollPhysics(),
                controller: PageController(
                    initialPage: pageNumber
                ),
                reverse: true,
                itemBuilder: (context, index) {
                    try {
                      return
                        Image.asset(
                          'assets/quran/' + quran_imgs[index],
                          fit: BoxFit.fill,
                        );
                    }
                    catch (e) {
                      print(e);

                  }

                },
              )),
        ),
        onTap: () {
          print('taped');
          _visibilitymethod();
        },
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        visible: _iconVisibility,
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        //  visible: _dialVisible,

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
            child: FloatingActionButton(
              heroTag: null,
              //   backgroundColor: backgroundColor,
              mini: true,
              child: new InkWell(
                child: Icon(Icons.add),
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllTeacher()));
                },
              ),
              onPressed: () {
                },
            ),
            backgroundColor: Colors.blue,
            label: 'All Teachers',),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.build),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllStudent()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'All Students',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.person),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'Profile',
            //    labelStyle: TextTheme(fontSize: 18.0),su
            onTap: () {},
          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.exit_to_app),
              onTap: () {
                handleSignOut();
                },
            ),
            backgroundColor: Colors.green,
            label: 'LogOut',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'Third',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'Third',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }

  Future<Null> handleSignOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    if(googleSignIn.currentUser == null) {
      Toast.show('Sign Out success', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }else {
      Toast.show('Faild to Sign Out', context,duration: Toast.LENGTH_LONG, backgroundColor: Colors.red);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
    }
    }
}

