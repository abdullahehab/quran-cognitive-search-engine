import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/const.dart';
import 'package:flutter_app/UI/Pages/editProfile.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences prefs;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';
  String email = '';
  String type = '';
  String birthDate = '';
  String stuEducation = '';
  String numOfReading = '';
  String numOfParts = '';
  String gender ='';
  String igaza = '';
  String university = '';
  var date = new DateTime.now().year;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    aboutMe = prefs.getString('aboutMe') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    email = prefs.getString('email');
    type = prefs.getString('userType');
    birthDate = prefs.getString('birthdate');
    stuEducation = prefs.getString('education');
    numOfReading = prefs.getString('numOfReading');
    numOfParts = prefs.getString('numOfParts');
    gender = prefs.getString('gender');
    igaza = prefs.getString('igaza');
    university = prefs.getString('university');

    // Force refresh input
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Colors.deepPurple,
          height: 200.0,
        ),
        ListView(children: [
          AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllQuran()))),
            title: Text("Profile"),
            backgroundColor: Colors.deepPurple,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  })
            ],
          ),
          Container(
            color: Colors.deepPurple,
            height: 250.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      photoUrl != '' ? Material(
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
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        clipBehavior: Clip.hardEdge,
                      ):
                       CircleAvatar(
                         backgroundImage: AssetImage('images/man.png'),
                       )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    nickname == null ? "Guest" : nickname,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  email == null ? "Guest@gmail.com" : email,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
          DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Basic Info'),
                      Tab(text: 'Education'),
                      //Tab(text: 'Experience')
                    ],
                    labelColor: Colors.black,
                    indicatorColor: Colors.deepPurple,
                    unselectedLabelColor: Colors.teal,
                  ),
                  Container(
                      height: 300.0,
                      child: TabBarView(
                        children: [
                          new ListView(
                            children: basicInfo(birthDate, aboutMe, date, gender),
                          ),
                          new ListView(
                            children: education(stuEducation, university, numOfParts, numOfReading, type, igaza),
                          ),
                          Center(child: Text('Education here')),
                        //  Center(child: Text('Experience here')),
                        ],
                      ))
                ],
              ))
        ]),
      ],
    ));
  }
}

List<Widget> basicInfo(String birthDate, String aboutMe, var date, String gender) => <Widget>[
  Column(
    children: <Widget>
    [
      SingleChildScrollView(
        child: Column
          (
            children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3.0,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.white)),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const ListTile(
                            subtitle: Text(
                              'Personal Info.',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 19.0),
                                child: Text(
                                  "Age: ${birthDate}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                "Gender: $gender",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child:
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 19.0),
                                  child: Text(
                                    "Nationality: 23 Years Old",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3.0,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.white)),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const ListTile(
                            subtitle: Text(
                              'About Me',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child:
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 19.0),
                                  child: Text(
                                    "$aboutMe",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  )
];


List<Widget> education(String education, String university, String numOfParts, String numOfReading, String userType, String igaza) => <Widget>[
  Column(
    children: <Widget>[
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3.0,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.white)),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const ListTile(
                            subtitle: Text(
                              "Academic Education",
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Icon(Icons.school),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "$university University",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "$education",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "$university",
                                  style: TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Icon(Icons.school),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Number Of Reading : $numOfReading",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                 Text(
                                "Number Of Parts : $numOfParts",
                                style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                userType == "Teacher" ?
Text(
"Igaza : $igaza",
style: TextStyle(
color: Colors.black,
fontSize: 22.0,
fontWeight: FontWeight.bold),
): Container()
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3.0,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.white)),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const ListTile(
                            subtitle: Text(
                              "Cources & Workshops",
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Icon(Icons.school),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "English School",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Thanawya amma (Egyption)",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "High Graduation School",
                                  style: TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Icon(Icons.school),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Helwan University",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Fine Arts- Decor Department",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 65.0, top: 3.0),
                            child: Row(
                              children: <Widget>[
                                userType == "Teacher" ?
                                Text(
                                  "Igaza $igaza",
                                  style: TextStyle(fontSize: 18.0),
                                ): Container()
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ],
  )
];
// Our top level main function
//void main() => runApp(new ProfilePage());
//end
