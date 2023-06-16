import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'Screen/recognization_page.dart';
import 'Utils/image_cropper_page.dart';
import 'Utils/image_picker_class.dart';
import 'Widgets/modal_dialog.dart';
import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

enum TtsState { playing, stopped }

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  double screenH = 0;
  double screenW = 0;
  int? previewH;
  int? previewW;
  double left = 0;
  double top = 0;
  double mid = 0;
  double woo = 0;
  final _debouncer = Debouncer(milliseconds: 1000);

  final flutterTts = FlutterTts();
  String? _newVoiceText;
  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  void initState() {
    super.initState();
    FlutterTts flutterTts = new FlutterTts();
    flutterTts.speak("Görme engelliler için yapılmış uygulamaya hoşgeldiniz, başlamak için lütfen ekranın herhangi bir yerine dokunun");

    initTts();
  }

  initTts() {
    FlutterTts flutterTts = new FlutterTts();

    // _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("ses dosyası çalıyor");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("tamamlandı");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("hata: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<void> _speak(String kelime) async {
    if (kelime.isNotEmpty) {
      var result = await flutterTts.speak(kelime);
      if (result == 1) setState(() => ttsState = TtsState.playing);
      return flutterTts.awaitSpeakCompletion(true);
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts!.stop();
  }

  loadModel() async {
    FlutterTts flutterTts = new FlutterTts();
    flutterTts.speak("Uygulama başlatılıyor");
    String? res;
    switch (_model) {
      case ssd:
        res = await Tflite.loadModel(
          model: "assets/ssd_mobilenet.tflite",
          labels: "assets/ssd_mobilenet.txt",
        );
        break;
      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
  }

  onSelect(model) async {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;

      sesDeneme();
    });
  }

  sesDeneme() async {
    Size screen = MediaQuery.of(context).size;
    screenW = screen.width;
    screenH = screen.height;
    previewH = math.max(_imageHeight, _imageWidth);
    previewW = math.min(_imageHeight, _imageWidth);

    _recognitions == null
        ? []
        : _recognitions!.map((re) async {
            var _x = re["rect"]["x"];
            var _w = re["rect"]["w"];
            var _y = re["rect"]["y"];
            var _h = re["rect"]["h"];
            var scaleW, scaleH, x, y, w, h;
            //print(_x);
            //print(_y);

            if (screenH / screenW > previewH! / previewW!) {
              scaleW = screenH / previewH! * previewW!;
              scaleH = screenH;
              //print(scaleH);
              //print(scaleW);
              var difW = (scaleW - screenW) / scaleW;
              x = (_x - difW / 2) * scaleW;
              w = _w * scaleW;
              if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
              y = _y * scaleH;
              h = _h * scaleH;
              //print(x);
              //print(y);
            } else {
              scaleH = screenW / previewW! * previewH!;
              scaleW = screenW;
              var difH = (scaleH - screenH) / scaleH;
              x = _x * scaleW;
              w = _w * scaleW;
              y = (_y - difH / 2) * scaleH;
              h = _h * scaleH;
              //print(x);
              //print(y);
              if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
              //print(x);
              //print(y);
            }

            left = math.max(0, x);
            top = math.max(0, y);

            print(left);
            print(w);
            woo = math.min(left + w, 480);
            mid = (left + w) / 2;
            print("-------");
            print(
                "Bu bir ${re["detectedClass"]} doğruluk değeri ${re["confidenceInClass"]}");
            print(mid);
            print("-------");
            if (re["confidenceInClass"] > 0.7) {
             
              _speak("Önünüzde ${re["detectedClass"]} var");
              
              if (mid >= 165) {
                _speak("Sağ tarafınızda ${re["detectedClass"]} var");
              } else {
                _speak("Sol tarafınızda ${re["detectedClass"]} var");
              }
            }
          }).toList();
    //var object = recognitions.where((user) => user[""] > 50);
    //print(object);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _model == ""
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 700,
                    width: 500,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white10,
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        "lütfen ekranın herhangi bir yerine dokununuz",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => onSelect(ssd), // ekrana tıklandığında aynı zamanda modeli seçiyoruz
                    ),
                  ),
                  Align( // metin tarama butonu ----> modal ekranı açılıyor
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.extended(
                      label: const Text("metin tara"),
                      icon: Icon(Icons.photo_camera),
                      onPressed: () {
                        imagePickerModal(context, onCameraTap: () {
                          log("Kamera acildi");
                          pickImage(source: ImageSource.camera).then((value) {
                            if (value != '') {
                              imageCropperView(value, context).then((value) {
                                if (value != '') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => RecognizePage(
                                        path: value,
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          });
                        }, onGalleryTap: () {
                          log("Galeri acildi");
                          pickImage(source: ImageSource.gallery).then((value) {
                            if (value != '') {
                              imageCropperView(value, context).then((value) {
                                if (value != '') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => RecognizePage(
                                        path: value,
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          });
                        });
                      },
                      tooltip: 'Increment',
                    ),
                  ),
                ],
              ),
            )
          : Stack(
            alignment: Alignment.bottomRight,
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                FloatingActionButton.extended(
                  label: const Text("metin tara"),
                  icon: Icon(Icons.photo_camera),
                    onPressed: () {
                      imagePickerModal(context, onCameraTap: () {
                        log("Kamera acildi");
                        pickImage(source: ImageSource.camera).then((value) {
                          if (value != '') {
                            imageCropperView(value, context).then((value) {
                              if (value != '') {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => RecognizePage(
                                      path: value,
                                    ),
                                  ),
                                );
                              }
                            });
                          }
                        });
                      }, onGalleryTap: () {
                        log("galeri acildi");
                        pickImage(source: ImageSource.gallery).then((value) {
                          if (value != '') {
                            imageCropperView(value, context).then((value) {
                              if (value != '') {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => RecognizePage(
                                      path: value,
                                    ),
                                  ),
                                );
                              }
                            });
                          }
                        });
                      });
                    },
                    tooltip: 'Increment',
                  ),
                BndBox(
                    _recognitions ?? [],
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
              ],
            ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
