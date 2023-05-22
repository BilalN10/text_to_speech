import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:typing/view/key_board_class.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:text_to_speech/text_to_speech.dart' as tts;

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
  //runApp(const MyApp());
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
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
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


// index_3: 100,
//               index_4: 100,
//               index_5: 100,
//               index_6: 100,
//               index_7: 100,
//               index_8: 100,
//               index_9: 100,
//               index_10: 100,
//               index_11: 100,
//               index_12: 100,
//               index_13: 100,
//               index_14: 100,
//               index_15: 100,
//               index_16: 100,
//               index_17: 100,
//               index_18: 100,
//               index_19: 100,
//               index_20: 100,
//               index_21: 100,
//               index_22: 100,
//               index_23: 100,
//               index_24: 100,
//               index_25: 100,
//               index_26: 100,
//               index_27: 100,
//               index_28: 100,
//               index_29: 100,
//               index_30: 100,
//               index_31: 100,
//               index_32: 100,
//               index_33: 100,
//               index_34: 100,
//               index_35: 100,
//               index_36: 100,
//               index_37: 100,
//               index_38: 100,
//               index_39: 100,
//               index_40: 100,
//               index_41: 100,
//               index_42: 100,
//               index_43: 100,
//               index_44: 100