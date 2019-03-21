import 'package:flutter/material.dart';
import 'package:watson_assistant/watson_assistant.dart';

class ChatBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyChatPage(),
    );
  }
}

class MyChatPage extends StatefulWidget {
  @override
  _MyChatPageState createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> with TickerProviderStateMixin{

  String _text;
  WatsonAssistantCredential credential = WatsonAssistantCredential(
      uri: "https://gateway-lon.watsonplatform.net/assistant/api/v1/",
      username: "apikey",
      password: "AsFfZQsMEhF3TVDXlv4tkoTF0lEVLOkxMoMK5rac3Zay",
      workspaceId: "7262e9e2-62da-47e6-8ede-8bb364549138");

  WatsonAssistantApiV1 watsonAssistant;
  WatsonAssistantResult watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
  WatsonAssistantContext(context: {});

  final myController = TextEditingController();

  void _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        myController.text, watsonAssistantContext);
    setState(() {
      _text = watsonAssistantResponse.resultText;
    });
    watsonAssistantContext = watsonAssistantResponse.context;
    myController.clear();
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV1(watsonAssistantCredential: credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.restore,
            ),
            onPressed: () {
              watsonAssistantContext.resetContext();
              setState(() {
                _text = null;
              });
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: myController,
            ),
            Text(
              _text != null ? '$_text' : 'Watson Response Here',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _callWatsonAssistant,
        child: Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

}

