import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/Pages/allStudent.dart';
import 'package:flutter_app/UI/Pages/allTeacher.dart';
import 'package:flutter_app/UI/Pages/profilePage.dart';
import 'package:flutter_app/helpers/Heplers.dart';
import 'package:flutter_app/quranList.dart';
import 'package:flutter_app/speed%20radial/speed_dial.dart';
import 'package:flutter_app/speed%20radial/speed_dial_child.dart';



class AllQuran extends StatefulWidget {
  @override
  _AllQuranState createState() => _AllQuranState();
}

class _AllQuranState extends State<AllQuran> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> gKey = new GlobalKey<ScaffoldState>();

  int pageNumber = 0;
//  final GoogleSignIn googleSignIn = GoogleSignIn();
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

  int pageNumberFunction(int num) {
      pageNumber = num;
//      setState(() {});
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
                    controller: PageController(
                        initialPage: 0
                    ),
                    reverse: true,
                    itemBuilder: (context, index) {
                      pageNumberFunction(index);
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
          /* Edit By Gehad Adelaziz 4/3/2019 1:20 pm*/
//          Container(
//              height: 70.0,
//              color: Colors.black.withOpacity(0.7),
//            child: Column(
//              children: <Widget>[
//                // Edit By Gehad Adelaziz 13/4/2019 3:14 pm
//                ListTile(
//                  leading:Text(" سوره البقرة ",style: TextStyle(color: Colors.white,fontSize: 20.0),),
//                  title: Center(child: Text("$pageNumber",style: TextStyle(color: Colors.white,fontSize: 20.0),)),
//                  trailing: Text(" الجزء الاول",style: TextStyle(color: Colors.white,fontSize: 20.0),),
//                ),
//              ],
//            ),
//          ),
        ],
      ),
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
            child: FloatingActionButton(
              heroTag: null,
              //   backgroundColor: backgroundColor,
              mini: true,
              child: new InkWell(
                child: Icon(Icons.person),
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllTeacher()));
                },
              ),
              onPressed: () {
                },
            ),
            backgroundColor: Colors.green,
            label: 'All Teachers',),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.chat),
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
              child: Icon(Icons.assignment_ind),
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
              child: Icon(Icons.chat),
              onTap: () {
                Helper help = new Helper();
//                help.loggedin();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => FriendlychatApp()));
              },
            ),
            backgroundColor: Colors.green,
            label: 'Chat-Bot',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'Voice Search',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
          SpeedDialChild(
            child: InkWell(
              child: Icon(Icons.exit_to_app),
              onTap: () {
                _logOut();
              },
            ),
            backgroundColor: Colors.green,
            label: 'LogOut',
            //    labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }

  _logOut() async{
    await _auth.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil("/login", ModalRoute.withName("/home"));
    });
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

