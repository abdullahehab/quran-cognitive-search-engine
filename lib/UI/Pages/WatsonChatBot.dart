import 'dart:convert';

import 'package:QCSE/UI/Pages/quran.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:watson_assistant/watson_assistant.dart';



class WatsonChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

//  final String title;
//  final String name = "mohamed";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text;
  List<String> _messages;
  List quran, highlight;
  int searchResult;
  ScrollController scrollController;
  String searchWord = '';
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

  void _callWatsonAssistant(String search) async {
    print(myController.text);
    searchWord = myController.text;
    setState(() {
      enableButton = false;
      myController.clear();
      _messages.add(search + searchWord);

      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            curve: Curves.ease, duration: Duration(milliseconds: 500));
      });
    });
    watsonAssistantResponse =
    await watsonAssistant.sendMessage(searchWord, watsonAssistantContext);
    print(watsonAssistantResponse.resultText);
    if (watsonAssistantResponse.resultText == "Testing") {
      setState(() {
        String requestText = searchWord;
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

  _makeDiscoveryRequest(String text) async {
    var input = text;

    String username = 'apikey';
    String password = 'jw4oSc5KLgobQN93TGS8xPhNMpuSWCJTlRH20Z1Xu3xq';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    const String DISCOVERY_ENVIRONMENT_ID =
        'da1cb970-9f9c-4a83-8f26-6e1d9ef0d1d2';
    const String DISCOVERY_COLLECTION_ID =
        'e1034a1c-b741-442e-a400-ff0ea07cd667';
    String version = '2018-12-03';
    print(basicAuth);

    Response response = await get(
        'https://gateway-lon.watsonplatform.net/discovery/api/v1/environments/$DISCOVERY_ENVIRONMENT_ID/collections/$DISCOVERY_COLLECTION_ID/query?version=2018-12-03&deduplicate=false&highlight=true&passages=true&passages.count=5&natural_language_query=$input',
        headers: {'authorization': basicAuth});

    int matching_results = json.decode(response.body)['matching_results'];

    setState(() {
      searchResult = matching_results;
      if ( searchResult == 0 ) {
        _messages.add('لا يوجد نتائج ادخل الايه صحيحه');
      }
    });

    print("matching_results : " + matching_results.toString());

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
          _messages.add(" اسم السوره : " +
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
          onPressed: () {
            _callWatsonAssistant('.');
          },
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

                if (_messages[index].contains('.')) {
                  print(index);
                  reverse = true;
                }
                var avatar = Padding(
                  padding:
                  const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'images/watson_logo.png',
                      color: Colors.deepPurple,
                    ),
                  ),
                );

                var triangle = CustomPaint(
                  painter: Triangle(),
                );

                var messagebody = DecoratedBox(
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
                  message = Stack(
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
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      avatar,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: message,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.amber,
          ),
          textInput
        ],
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
