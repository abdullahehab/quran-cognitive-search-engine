import 'dart:convert';
import 'package:QCSE/UI/Pages/quran.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:watson_assistant/watson_assistant.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Watson Assistant Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text;
  List<String> _messages;
  List quran, highlight;
  int searchResult ;
  ScrollController scrollController;

  bool enableButton = false;

  WatsonAssistantCredential credential = WatsonAssistantCredential(
    username: "apikey",
    password: "AsFfZQsMEhF3TVDXlv4tkoTF0lEVLOkxMoMK5rac3Zay",
    workspaceId: "7262e9e2-62da-47e6-8ede-8bb364549138",
    version: "2018-09-20",
    uri: "https://gateway-lon.watsonplatform.net/assistant/api/v1/",
  );

  WatsonAssistantApiV1 watsonAssistant;
  WatsonAssistantResult watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
  WatsonAssistantContext(context: {});

  final myController = TextEditingController();

  void _callWatsonAssistant() async {
    print(myController.text);
    setState(() {
      _messages.add(myController.text);
    });
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        myController.text, watsonAssistantContext);
    print(watsonAssistantResponse.resultText);
    if (watsonAssistantResponse.resultText == "Testing Discovery...") {
      setState(() {
        String requestText = myController.text;
        print(requestText);
        _makeDiscoveryRequest(requestText);
        print('call discovery');
      });
    } else {
      setState(() {
        _messages.add(watsonAssistantResponse.resultText);
      });
    }
    watsonAssistantContext = watsonAssistantResponse.context;
    myController.clear();
  }

  void handleSendMessage(String text) {
    myController.clear();
    setState(() {
      _messages.add(text);
      enableButton = false;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          curve: Curves.ease, duration: Duration(milliseconds: 500));
    });
  }

  _makeDiscoveryRequest(String text) async {
    var input = text;

    String username = 'apikey';
    String password = 'jw4oSc5KLgobQN93TGS8xPhNMpuSWCJTlRH20Z1Xu3xq';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    const String DISCOVERY_ENVIRONMENT_ID =
        'da1cb970-9f9c-4a83-8f26-6e1d9ef0d1d2';
    const String DISCOVERY_COLLECTION_ID =
        '8f408c86-b798-4fb7-9904-27822a0f2dbe';
    String version = '2018-12-03';
    print(basicAuth);

    Response response = await get(
        'https://gateway-lon.watsonplatform.net/discovery/api/v1/environments/$DISCOVERY_ENVIRONMENT_ID/collections/$DISCOVERY_COLLECTION_ID/query?version=2018-12-03&deduplicate=false&highlight=true&passages=true&passages.count=5&natural_language_query=$input',
        headers: {'authorization': basicAuth});

//    int matching_results = json.decode(response.body)['matching_results'];
//
//    setState(() {
//      searchResult = matching_results;
//    });
//
//    print("matching_results" + matching_results.toString());

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      quran = (json.decode(response.body)['results'] as List)
          .map((data) => new Quran.fromJson(data))
          .toList();


      for (var q in quran) {
        print(q.id);
        print(q.name);
        setState(() {
          _messages.add(" اسم الصوره : " +
              q.name +
              "\n" +
              "عدد ايات السوره : " +
              q.count +
              "\n" +
              "رقم الجزء : " +
              q.juz +
              "\n" +
              "مكان النزول : " +
              q.place +
              "\n" +
              "نوع السوره : " +
              q.type +
              "\n" +
              "رقم السوره : " +
              q.index);
        });
      }
    }
  }

  @override
  void initState() {
    _messages = List<String>();

    scrollController = ScrollController();

    super.initState();
    watsonAssistant =
        WatsonAssistantApiV1(watsonAssistantCredential: credential);

  }

  @override
  Widget build(BuildContext context) {
    var textInput = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  enableButton = text.isNotEmpty;
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: "Type a message",
              ),
              controller: myController,
            ),
          ),
        ),
        enableButton
            ? IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.send,
          ),
          disabledColor: Colors.grey,
          onPressed: _callWatsonAssistant,
        )
            : IconButton(
          color: Colors.blue,
          icon: Icon(
            Icons.send,
          ),
          disabledColor: Colors.grey,
          onPressed: null,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {},
        ),
        title: Text("Watson Chat-Bot",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.restore,
            ),
            onPressed: () {
              watsonAssistantContext.resetContext();
              setState(() {
                _messages.clear();
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool reverse = false;


                if (index % 2 == 0) {
                  print(index);
                  reverse = true;
                }
                var avatar = Padding(
                  padding:
                  const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('images/watson_logo.png',color: Colors.deepPurple,),
                  ),
                );

                var triangle = CustomPaint(
                  painter: Triangle(),
                );

                var messagebody =
                DecoratedBox(
                  position: DecorationPosition.background,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(_messages[index]),
                    ),
                  ),
                );

                Widget message;

                if (reverse) {
                  message =
                      Stack(
                        children: <Widget>[
                          messagebody,
                          Positioned(right: 0, bottom: 0, child: triangle),
                        ],
                      );
                } else {
                  message = Stack(
                    children: <Widget>[
                      Positioned(left: 0, bottom: 0, child: triangle),
                      messagebody,
                    ],
                  );
                }

//                Widget des;

                if (reverse) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: message,
                      ),
                      avatar,
                    ],
                  );
                } else {
                  return
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        avatar,
                        Expanded(
                          child: SizedBox(
                            height: 250.0,
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: quran.length,
                              itemBuilder: (BuildContext context, int index) => Card(
                                child: menuCard(quran[index].name, quran[index].name, quran[index].count, quran[index].type,quran[index].juz),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                }
              },
            ),
          ),
          Divider(height: 2.0,color: Colors.amber,),
          textInput
        ],
      ),
    );
  }

  Widget menuCard(String title,  String name, String num_of_verses , String type ,String description){
    return Padding(
      padding: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Material(
        borderRadius: BorderRadius.circular(7.0),
        elevation: 4.0,
        child: Container(
            margin: EdgeInsets.all(8.0),
            //width: MediaQuery.of(context).size.width,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                          flex: 11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  //background: Paint()..color = Colors.grey,
                                ),
                              ),
                            ],
                          )
                      ),
                    ],),
                  SizedBox(height: 20.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(' سورة : ' + name,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('  عدد الايات : ' + num_of_verses.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),),
                    ],),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(' نوع الاية : '+ type,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],),
                ],
              ),
            )
        ),
      ),
    );
  }


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

class Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.amber;

    var path = Path();
    path.lineTo(10, 0);
    path.lineTo(0, -10);
    path.lineTo(-10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
