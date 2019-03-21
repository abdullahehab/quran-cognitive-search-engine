/*
import 'package:flutter/material.dart';

final ThemeData androidTheme = new ThemeData(
  primaryColor: Colors.blue[800],
  accentColor: Colors.green[100]
);

const String defaultName = "watson chatbot";

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Application",
      theme: androidTheme,
      home: new Chat(),
    );
  }
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin{

  final List<Msg> _message = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watson chatbot'),
        elevation: 6.0,
      ),
      body: Column(
        children: <Widget>[
          new Flexible(
              child: ListView.builder(
                  itemBuilder: (_, int index) => _message[index],
                itemCount: _message.length,
                reverse: true,
                padding: EdgeInsets.all(6.0),
              )
          ),
          Divider(height: 1.0,),
          Container(
            child: _buildComposer(),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor
            ),
          )
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                  child: new TextField(
                    controller: _textController,
                    onChanged: (String txt) {
                      setState(() {
                        _isWriting = txt.length > 0;
                      });
                    },
                    onSubmitted: _submitMsg,
                    decoration: InputDecoration.collapsed(hintText: "Enter Some Text"),
                  )
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 3.0),
                child: IconButton(
                    icon: Icon(Icons.message),
                    onPressed: _isWriting ? () =>  _submitMsg(_textController.text) : null
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            border: new Border(
              top: BorderSide(
                color: Colors.brown[200]
              )
            )
          ),
        )
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(vsync: this,duration: Duration(microseconds: 800)),
    );
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController,
            curve: Curves.bounceOut
        ),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                child: Text(defaultName[0]),
              ),
            ),
            new Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(defaultName, style: Theme.of(context).textTheme.subhead,),
                    Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: Text(txt),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
*/
