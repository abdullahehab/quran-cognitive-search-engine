import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'package:QCSE/UI/Pages/quran.dart';
//import 'package:QCSE/UI/QuranWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medcorder_audio/medcorder_audio.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'quran.dart';

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

  bool visibilityDesc = false;
  bool visibilityReco = false;

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
        'e1034a1c-b741-442e-a400-ff0ea07cd667';
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

      setState(() {
        voiceResult = result['results'][0];
      });
      print(voiceResult);
      if (voiceResult != null) {
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
    _makeDiscoveryRequest('الحمد لله رب العالمين');
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
      fetchData();
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
        //        fetchData();
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
  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "obs") {
        visibilityDesc = visibility;
      }
      if (field == "tag") {
        visibilityReco = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.restore,
              ),
              onPressed: () {
                quran.clear();
                setState(() {
                  voiceResult = '';
                });
              },
            )
          ],
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllQuran()));*/
            },
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: new Text(
            voiceResult == '' ? 'Voice Search' : voiceResult,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Center(
                    child: canRecord
                        ? new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        quran.length != 0
                            ? Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  reverse: true,
                                  padding:
                                  EdgeInsets.only(right: 38.0),
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: quran.length,
                                  itemBuilder:
                                      (BuildContext context,
                                      int index) =>
                                      Card(
                                        child: menuCard(
                                            quran[index].name,
                                            quran[index].count,
                                            quran[index].juz,
                                            quran[index].place,
                                            quran[index].type,
                                            quran[index].index,
                                            '',
                                            context,
                                            quran[index].order,
                                            quran[index]
                                                .prostration,
                                            quran[index]
                                                .subject),
                                      ),
                                ),
                              ),
                            )
                          ],
                        )
                            : Container(
                          child: SizedBox(
                            height: 300.0,
                          ),
                        ),
                      ],
                    )
                        : new Text(
                      'Microphone Access Disabled.\nYou can enable access in Settings',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
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
                  ),
                ))
          ],
        )
    );
  }

  Widget menuCard(
      String name,
      String count,
      String juz,
      String place,
      String type,
      String index,
      String description,
      BuildContext context,
      String order,
      String prostration,
      String subject) {
    return Padding(
      padding: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Material(
        borderRadius: BorderRadius.circular(7.0),
        elevation: 4.0,
        child: Container(
            margin: EdgeInsets.all(8.0),
            //width: MediaQuery.of(context).size.width,
            width: 330,
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
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    //background: Paint()..color = Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'رقم السوره : ' + index,
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
                        child: Text(
                          '  عدد الايات : ' + count,
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
                        child: Text(
                          ' نوع السوره : ' + type,
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
                        child: Text(
                          ' مكان النزول  : ' + place,
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
                        child: Text(
                          'رقم الجزء : ' + juz,
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
                        child: Text(
                          'ترتيب النزول  : ' + order,
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
                        child: Text(
                          'سجده التلاوه  : ' + prostration,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                          onTap: () {
                            print('test');
                          },
                          child: new Container(
                            //                            margin: new EdgeInsets.only(top: 5.0),
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.description,
                                    color: visibilityDesc
                                        ? Colors.grey[400]
                                        : Colors.grey[600]),
                                new Container(
                                  margin: const EdgeInsets.only(top: 1.0),
                                  child: FlatButton(
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    color: Color(0xFFFA624F),
                                    onPressed: () {
                                      visibilityDesc
                                          ? null
                                          : _changed(true, "obs");
                                    },
                                    child: Text(
                                      ' موضوع السوره ' + description,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  visibilityDesc
                      ? new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        flex: 20,
                        child: Text(subject),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17.0),
                            child: IconButton(
                              color: Colors.grey[400],
                              alignment: AlignmentDirectional.topCenter,
                              icon: const Icon(
                                Icons.cancel,
                                size: 20.0,
                              ),
                              onPressed: () {
                                _changed(false, "obs");
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                      : new Container(),
                  visibilityReco
                      ? new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Expanded(
                        flex: 11,
                        child: new TextField(
                          maxLines: 1,
                          style: Theme.of(context).textTheme.title,
                          decoration: new InputDecoration(isDense: true),
                        ),
                      ),
                      new Expanded(
                        flex: 1,
                        child: new IconButton(
                          color: Colors.grey[400],
                          icon: const Icon(
                            Icons.cancel,
                            size: 22.0,
                          ),
                          onPressed: () {
                            _changed(false, "tag");
                          },
                        ),
                      ),
                    ],
                  )
                      : new Container(),
                ],
              ),
            )),
      ),
    );
  }
}
