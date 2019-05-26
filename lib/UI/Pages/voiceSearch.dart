import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/UI/Pages/quran.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/Pages/speechToText.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:http/http.dart';
import 'package:medcorder_audio/medcorder_audio.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class VoiceSearch extends StatefulWidget {
  @override
  _VoiceSearchState createState() => _VoiceSearchState();
}

class _VoiceSearchState extends State<VoiceSearch> {
  MedcorderAudio audioModule = new MedcorderAudio();
  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";
  String fileUrl = "";
  List text;
  String voiceResult = "";
  List quran = [];
  bool isGettingResul = false;

  TextEditingController myController = new TextEditingController();

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

    http.Response response = await get(
        'https://gateway-lon.watsonplatform.net/discovery/api/v1/environments/$DISCOVERY_ENVIRONMENT_ID/collections/$DISCOVERY_COLLECTION_ID/query?version=2018-12-03&deduplicate=false&highlight=true&passages=true&passages.count=5&natural_language_query=$input',
        headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      isGettingResul = true;
      print(response.statusCode);
      print(response.body);
      quran = (json.decode(response.body)['results'] as List)
          .map((data) => new Quran.fromJson(data))
          .toList();
      print('length');
      print(quran.length);

      for (var q in quran) {
        print(q.id);
        print(q.name);

      }
      setState(() {});
    }
  }

  Future<void> fetchData() async {

    await convertFileActionApi(fileUrl).then((response) {

      Map<String, dynamic> result = json.decode(response.toString());

      voiceResult = result['results'][0];
      print(voiceResult);
      if ( voiceResult != null) {
        _makeDiscoveryRequest(voiceResult);
      } else {
        print('no result to search');
      }
      return response;
    });
  }

  Future convertFileActionApi(file) async {
    String uri = "https://quiet-hamlet-78778.herokuapp.com/convert-file";

    Dio dio = new Dio();
    FormData formdata = new FormData();
    formdata.add("file",
        new UploadFileInfo(File.fromUri(Uri.parse(file)), basename(file)));
    return await dio
        .post(uri,
            data: formdata,
            options: Options(
              method: 'POST',
              responseType: ResponseType.json,
            ))
        .then((response) {
      return response;
    }).catchError((error) => print(error));
  }



  @override
  initState() {
    print(quran.length);
    super.initState();
    audioModule.setCallBack((dynamic data) {
      _onEvent(data);
    });
    _initSettings();
  }

  Future _initSettings() async {
    final String result = await audioModule.checkMicrophonePermissions();
    if (result == 'OK') {
      await audioModule.setAudioSettings();
      setState(() {
        canRecord = true;
      });
    }
    return;
  }

  Future _startRecord() async {
    try {
      DateTime time = new DateTime.now();
      setState(() {
        file = time.millisecondsSinceEpoch.toString();
      });
      final String result = await audioModule.startRecord(file);
      setState(() {
        isRecord = true;
      });
      print('startRecord: ' + result);
    } catch (e) {
      file = "";
      print('startRecord: fail');
    }
  }

  Future _stopRecord() async {
    try {
      final String result = await audioModule.stopRecord();
      print('stopRecord: ' + result);
      setState(() {
        isRecord = false;
      });
    } catch (e) {
      print('stopRecord: fail');
      setState(() {
        isRecord = false;
      });
    }
  }

  Future _startStopPlay() async {
    if (isPlay) {
      await audioModule.stopPlay();
    } else {
      print('test');
      print(file);
      print('end test');

      await audioModule.startPlay({
        "file": file,
        "position": 0.0,
      });
      if (fileUrl.length > 0) {
        fetchData();
      } else {
        print("invalid length");
      }
    }
  }

  void _onEvent(dynamic event) {
    if (event['code'] == 'recording') {
      double power = event['peakPowerForChannel'];
      String url = event['url'];
      setState(() {
        recordPower = (60.0 - power.abs().floor()).abs();
        recordPosition = event['currentTime'];
        fileUrl = url;
      });
    }
    if (event['code'] == 'playing') {
      String url = event['url'];
      setState(() {
        playPosition = event['currentTime'];
        isPlay = true;
//        fileUrl = url;
      });
    }
    if (event['code'] == 'audioPlayerDidFinishPlaying') {
      setState(() {
        playPosition = 0.0;
        isPlay = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AllQuran()));
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.deepPurple,
          title: new Text(
            'Voice Search',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child:
          canRecord
              ? new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              quran.length != 0 ?
              Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 250.0,
                        child: ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.only(right: 38.0),
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: quran.length,
                          itemBuilder: (BuildContext context, int index) => Card(
                            child: menuCard(quran[index].name, quran[index].count, quran[index].juz, quran[index].place, quran[index].type, quran[index].index),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ):Container(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                        child: isRecord
                            ? new Icon(Icons.mic_off)
                            : Icon(Icons.mic),
                        onPressed: () {
                          if (isRecord) {
                            _stopRecord();
                          } else {
                            _startRecord();
                          }
                        }),
                    SizedBox(
                      width: 19.0,
                    ),
//              new Text('recording: ' + recordPosition.toString()),
//              new Text('power: ' + recordPower.toString()),
                    FloatingActionButton(
                        child: isPlay
                            ? new Icon(Icons.play_circle_filled)
                            : Icon(Icons.pause_circle_filled),
                        onPressed: () {
                          if (!isRecord && file.length > 0) {
                            _startStopPlay();
                          }
                        }),
//              new Text('playing: ' + playPosition.toString()),
                  ],
                ),
              )
            ],
          )
              : new Text(
            'Microphone Access Disabled.\nYou can enable access in Settings',
            textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
  Widget menuCard(String name,  String count, String juz , String place ,String type, String index){
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(name,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    //background: Paint()..color = Colors.grey,
                                  ),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('رقم السوره : ' + index,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('  عدد الايات : ' + count,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),),
                      ),
                    ],),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(' نوع السوره : '+ type,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(' مكان النزول  : '+ place,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('رقم الجزء : '+ juz,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

}
