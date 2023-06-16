import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.speak(text);
  }
 

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Metin Tanıma")),
        body: _isBusy == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 500,
                      child: TextFormField(
                        maxLines: MediaQuery.of(context).size.height.toInt(),
                        controller: controller,
                        decoration:
                            const InputDecoration(hintText: "Metin bulunamadı..."),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(onPressed: (){
                        speak(controller.text);
                      }, child: Text("Seslendir")),
                    )
                  ],
                ),
              ));
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller.text = recognizedText.text;

    ///meşgul ise bitirir
    setState(() {
      _isBusy = false;
    });
  }
}
