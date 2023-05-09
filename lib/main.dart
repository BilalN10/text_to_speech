import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:typing/view/key_board_class.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:text_to_speech/text_to_speech.dart' as tts;

void main() {
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const MyApp(), // Wrap your app
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//PmVjOlrohp3x9dN17ZzEx70YCofYQQMuxoAp2QQ5
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Typing',
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: KeyboardScreen(),
      );
    });
  }
}

class Checl extends StatefulWidget {
  const Checl({super.key});

  @override
  State<Checl> createState() => _CheclState();
}

//TextToSpeech tts = TextToSpeech();

txtToSpeach() async {
  //tts.TextToSpeech().getDisplayLanguageByCode();
  //List<String> voices = await tts.TextToSpeech().getLanguages();
  String language = 'he-IL';
  List<String>? voices = await tts.TextToSpeech().getVoiceByLang(language);
  log('voices is $voices');

//List<String> voices = await tts.getVoices();
// //List<String> voices = await tts.getVoiceByLang(language);
  String text = "הצגת טקסט בעברית";
  tts.TextToSpeech().speak(text);
}

class _CheclState extends State<Checl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  txtToSpeach();
                },
                child: Text('txt to speecj'))
          ],
        ),
      ),
    );
  }
}
