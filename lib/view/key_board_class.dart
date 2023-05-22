import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:typing/view/book_mark_page.dart';
import 'package:typing/view/text_to_speech.dart';
import 'package:url_launcher/url_launcher.dart';

class KeyboardScreen extends StatefulWidget {
  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final TextToSpeech tts = TextToSpeech();
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _bookmarkedItems = [];

  final List<String> _hebrewbookmarkedItems = [];

  SharedPreferences? _prefs;
  Offset? _position;

  @override
  void initState() {
    //  _position = Offset(0, 0);
    super.initState();
    _loadBookmarks();
  }

  final _audioPlayer = AudioPlayer();
  bool isApiCall = false;
  Future<void> _getAudioFromAPI(String text) async {
    isApiCall = true;
    String apiEndpoint = 'https://api.narakeet.com/text-to-speech/mp3';
    String apiKey = 'PmVjOlrohp3x9dN17ZzEx70YCofYQQMuxoAp2QQ5';
    var params = {
      'voice': 'Ayelet',
    };
    try {
      final response =
          await http.post(Uri.parse(apiEndpoint + '?' + _encodeParams(params)),
              headers: {
                'x-api-key': _prefs!.getString('api_key')!,
                'Content-Type': 'text/plain',
                'accept': 'application/octet-stream',
              },
              body: text);

      log('resonse is ${response.body}');
      log('resonse is ${response.statusCode}');

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/audio.mp3';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await _audioPlayer.setFilePath(filePath);
        setState(() {
          isApiCall = false;
        });
        await _playAudio();
      } else if (response.statusCode == 400) {
        log('--------------');
        setState(() {
          isApiCall = false;
        });
        Get.snackbar('Failed', 'Enter valid sentance || word',
            colorText: Colors.white);
      } else if (response.statusCode == 403) {
        log('--------------');
        setState(() {
          isApiCall = false;
        });
        Get.snackbar(
            'Failed', 'Your Api key is not correct || maybe its expire',
            colorText: Colors.white);
      } else {
        setState(() {
          isApiCall = false;
        });
        Get.snackbar(
            'Failed', 'Your Api key is not correct || maybe its expire',
            colorText: Colors.white);
      }
    } on SocketException {
      setState(() {
        isApiCall = false;
      });
      Get.snackbar('Network error', 'No internet', colorText: Colors.white);
    }
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play();
  }

  void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  String _encodeParams(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _loadBookmarks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkedItems.addAll(_prefs!.getStringList('bookmarks') ?? []);
      _hebrewbookmarkedItems
          .addAll(_prefs!.getStringList('hebrew_bookmarks') ?? []);
    });
  }

  void _addBookmark(String text) {
    setState(() {
      if (selectedLanguge == 1) {
        _bookmarkedItems.add(text);
        _prefs!.setStringList('bookmarks', _bookmarkedItems);
      } else {
        _hebrewbookmarkedItems.add(text);
        _prefs!.setStringList('hebrew_bookmarks', _hebrewbookmarkedItems);
      }
    });
  }

  double _buttonSize = 100.0; // Initial size of the button

  void _clearInput() {
    setState(() {
      _textEditingController.clear();
    });
  }

  void _handleTextInput(String text) {
    setState(() {
      _textEditingController.text += text;
    });
    //tts.speak(_textEditingController.text);
  }

  removeLastCharater() {
    String text = _textEditingController.text;
    if (text.isNotEmpty) {
      text = text.substring(0, text.length - 1);
      _textEditingController.text = text;
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length),
      );
    }
  }

  bool _isHovering = false;
  int selectedIndex = 0;
  int otherIndex_1 = 0;
  int otherIndex_2 = 0;
  int otherIndex_3 = 0;
  int otherIndex_4 = 0;
  int otherIndex_5 = 0;
  int otherIndex_6 = 0;
  int otherIndex_7 = 0;
  int otherIndex_8 = 0;
  int otherIndex_9 = 0;
  int otherIndex_10 = 0;
  int otherIndex_11 = 0;
  int otherIndex_12 = 0;
  int otherIndex_13 = 0;
  int otherIndex_14 = 0;
  int otherIndex_15 = 0;
  int otherIndex_16 = 0;
  int otherIndex_17 = 0;
  int otherIndex_18 = 0;
  int otherIndex_19 = 0;
  int otherIndex_20 = 0;
  int otherIndex_21 = 0;
  int otherIndex_22 = 0;
  int otherIndex_23 = 0;
  int otherIndex_24 = 0;
  int otherIndex_25 = 0;
  int otherIndex_26 = 0;
  int otherIndex_27 = 0;
  int otherIndex_28 = 0;
  int otherIndex_29 = 0;
  int otherIndex_30 = 0;
  int otherIndex_31 = 0;
  int otherIndex_32 = 0;
  int otherIndex_33 = 0;
  int otherIndex_41 = 0;
  int otherIndex_42 = 0;
  int otherIndex_43 = 0;
  int otherIndex_44 = 0;
  int otherIndex_45 = 0;
  int otherIndex_46 = 0;
  int otherIndex_47 = 0;
  int otherIndex_48 = 0;
  int otherIndex_49 = 0;
  int otherIndex_50 = 0;
  int otherIndex_51 = 0;

  Map<String, int> englishMap = {
    "1": 41,
    "2": 42,
    "3": 43,
    "4": 44,
    "5": 45,
    "6": 46,
    "7": 47,
    "8": 48,
    "9": 49,
    "0": 50,
    'clear': 51,
    "q": 1,
    "w": 2,
    "e": 3,
    "r": 4,
    "t": 5,
    "y": 6,
    "u": 7,
    "i": 8,
    "o": 9,
    "p": 10,
    'cross': 11,
    "a": 13,
    "s": 14,
    "d": 15,
    "f": 16,
    "g": 17,
    "h": 18,
    "j": 19,
    "k": 20,
    "l": 21,
    "?": 12,
    'enter': 22,
    "upper": 23,
    "'": 24,
    "z": 25,
    "x": 26,
    "c": 27,
    "v": 28,
    "b": 29,
    "n": 30,
    "m": 31,
    ".": 32,
    ',': 33,
    "star": 34,
    'space': 35,
    'NN': -6
  };
  Widget contianerTile(int index, Function()? onTap, String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        print('enter');
        setState(() {
          //  myvalue = true;
        });
      },
      onHover: (event) {
        setState(() {
          selectedIndex = index;
        });
      },
      onExit: (event) {
        setState(() {
          setState(() {
            selectedIndex = 0;
          });
          //   myvalue = false;
        });
      },
      child: Column(
        children: [
          if (selectedIndex == index) Text('yes'),
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              // padding: EdgeInsets.symmetric(
              //   horizontal: selectedIndex == index ? Adaptive.w(3) : Adaptive.w(),
              //   vertical: selectedIndex == index ? Adaptive.h(5) : Adaptive.h(4),
              // ),
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              width: selectedIndex == index
                  ? MediaQuery.of(context).size.width <= 400
                      ? Adaptive.w(22)
                      : Adaptive.w(20)
                  : Adaptive.w(19),
              height: selectedIndex == index ? Adaptive.h(12) : Adaptive.h(7.5),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)]

                  //  borderRadius: BorderRadius.circular(10.0),
                  ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          if (selectedIndex != index) SizedBox()
        ],
      ),
    );
  }

  Widget bookMarkTile(int index, Function()? onTap, String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        print('enter');
        setState(() {
          //  myvalue = true;
        });
      },
      onHover: (event) {
        setState(() {
          selectedIndex = index;
        });
      },
      onExit: (event) {
        setState(() {
          setState(() {
            selectedIndex = 0;
          });
          //   myvalue = false;
        });
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
          width: selectedIndex == index ? Adaptive.w(55) : Adaptive.w(50),
          height: selectedIndex == index ? Adaptive.h(7) : Adaptive.h(6),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.0),

              // shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isUpperCaseFalse = false;
  changeWord() {
    setState(() {
      isUpperCaseFalse = !isUpperCaseFalse;
      print('case is $isUpperCaseFalse');
    });
  }

  bool isHover = false;

  Widget checkTile({
    required int index,
    required Function()? onTap,
    required String text,
    double? height,
    double? width,
    int? index_41,
    int? index_42,
    int? index_43,
    int? index_44,
    int? index_45,
    int? index_46,
    int? index_47,
    int? index_48,
    int? index_49,
    int? index_50,
    int? index_51,
    int? index_1,
    int? index_2,
    int? index_3,
    int? index_4,
    int? index_5,
    int? index_6,
    int? index_7,
    int? index_8,
    int? index_9,
    int? index_10,
    int? index_11,
    int? index_12,
    int? index_13,
    int? index_14,
    int? index_15,
    int? index_16,
    int? index_17,
    int? index_18,
    int? index_19,
    int? index_20,
    int? index_21,
    int? index_22,
    int? index_23,
    int? index_24,
    int? index_25,
    int? index_26,
    int? index_27,
    int? index_28,
    int? index_29,
    int? index_30,
    int? index_31,
    int? index_32,
    int? index_33,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {},
      onHover: (event) {
        selectedIndex = index;

        setState(() {
          if (index == 41) {
            otherIndex_41 = index_41!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 42) {
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;

            otherIndex_42 = index_42!;
          } else if (index == 43) {
            otherIndex_43 = index_43!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 44) {
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;

            otherIndex_44 = index_44!;
          } else if (index == 45) {
            otherIndex_45 = index_45!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 46) {
            otherIndex_46 = index_46!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 47) {
            otherIndex_47 = index_47!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 48) {
            otherIndex_48 = index_48!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 49) {
            otherIndex_49 = index_49!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 50) {
            otherIndex_50 = index_50!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_51 = 0;
          } else if (index == 51) {
            otherIndex_51 = index_51!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
          } else if (index == 1) {
            otherIndex_1 = index_1!;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 2) {
            otherIndex_1 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;

            otherIndex_2 = index_2!;
          } else if (index == 3) {
            otherIndex_3 = index_3!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 4) {
            otherIndex_4 = index_4!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 5) {
            otherIndex_5 = index_5!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 6) {
            otherIndex_6 = index_6!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 7) {
            otherIndex_7 = index_7!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 8) {
            otherIndex_8 = index_8!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 9) {
            otherIndex_9 = index_9!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 10) {
            otherIndex_10 = index_10!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 11) {
            otherIndex_11 = index_11!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 12) {
            otherIndex_12 = index_12!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 13) {
            otherIndex_13 = index_13!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 14) {
            otherIndex_14 = index_14!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 15) {
            otherIndex_15 = index_15!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 16) {
            otherIndex_16 = index_16!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 17) {
            otherIndex_17 = index_17!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 18) {
            otherIndex_18 = index_18!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 19) {
            otherIndex_19 = index_19!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 20) {
            otherIndex_20 = index_20!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 21) {
            otherIndex_21 = index_21!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 22) {
            otherIndex_22 = index_22!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 23) {
            otherIndex_23 = index_23!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 24) {
            otherIndex_24 = index_24!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 25) {
            otherIndex_25 = index_25!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 26) {
            otherIndex_26 = index_26!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 27) {
            otherIndex_27 = index_27!;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 28) {
            otherIndex_28 = index_28!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 29) {
            otherIndex_29 = index_29!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 30) {
            otherIndex_30 = index_30!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 31) {
            otherIndex_31 = index_31!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 32) {
            otherIndex_32 = index_32!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          } else if (index == 33) {
            otherIndex_33 = index_33!;

            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          }
        });
      },
      onExit: (event) {
        setState(() {
          setState(() {
            selectedIndex = 0;
            otherIndex_1 = 0;
            otherIndex_2 = 0;
            otherIndex_3 = 0;
            otherIndex_4 = 0;
            otherIndex_5 = 0;
            otherIndex_6 = 0;
            otherIndex_7 = 0;
            otherIndex_8 = 0;
            otherIndex_9 = 0;
            otherIndex_10 = 0;
            otherIndex_11 = 0;
            otherIndex_12 = 0;
            otherIndex_13 = 0;
            otherIndex_14 = 0;
            otherIndex_15 = 0;
            otherIndex_16 = 0;
            otherIndex_17 = 0;
            otherIndex_18 = 0;
            otherIndex_19 = 0;
            otherIndex_20 = 0;
            otherIndex_21 = 0;
            otherIndex_22 = 0;
            otherIndex_23 = 0;
            otherIndex_24 = 0;
            otherIndex_25 = 0;
            otherIndex_26 = 0;
            otherIndex_27 = 0;
            otherIndex_28 = 0;
            otherIndex_29 = 0;
            otherIndex_30 = 0;
            otherIndex_31 = 0;
            otherIndex_32 = 0;
            otherIndex_33 = 0;
            otherIndex_41 = 0;
            otherIndex_42 = 0;
            otherIndex_43 = 0;
            otherIndex_44 = 0;
            otherIndex_45 = 0;
            otherIndex_46 = 0;
            otherIndex_47 = 0;
            otherIndex_48 = 0;
            otherIndex_49 = 0;
            otherIndex_50 = 0;
            otherIndex_51 = 0;
          });
          //   myvalue = false;
        });
      },
      child: Column(
        children: [
          // ]]  if (index == 41)
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              // padding: EdgeInsets.symmetric(
              //   horizontal: selectedIndex == index ? Adaptive.w(3) : Adaptive.w(),
              //   vertical: selectedIndex == index ? Adaptive.h(5) : Adaptive.h(4),
              // ),
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              width: width,
              //     : otherIndex_1 == 0 ||
              //             otherIndex_2 == 0 ||
              //             otherIndex_3 == 0 ||
              //             otherIndex_4 == 0 ||
              //             otherIndex_5 == 0 ||
              //             otherIndex_6 == 0 ||
              //             otherIndex_7 == 0 ||
              //             otherIndex_8 == 0
              //         ? width!
              //         : width! + 9,
              // selectedIndex == index
              //     // ? MediaQuery.of(context).size.width <= 400
              //     ? width! + 13
              //     : otherIndex_1 == index_1 ||otherIndex_2 == index_2 ||
              //             otherIndex_3 == index_3 ||
              //             otherIndex_4 == index_4 ||
              //             otherIndex_5 == index_5 ||
              //             otherIndex_6 == index_6 ||
              //             otherIndex_7 == index_7 ||
              //             otherIndex_8 == index_8
              //         ? width! + 9
              //         : width,
              // : Adaptive.w(19),
              height: selectedIndex == index
                  ? height! + 30
                  : index_1 == otherIndex_1 ||
                          index_2 == otherIndex_2 ||
                          index_3 == otherIndex_3 ||
                          index_4 == otherIndex_4 ||
                          index_5 == otherIndex_5 ||
                          index_6 == otherIndex_6 ||
                          index_7 == otherIndex_7 ||
                          index_8 == otherIndex_8 ||
                          index_9 == otherIndex_9 ||
                          index_10 == otherIndex_10 ||
                          index_11 == otherIndex_11 ||
                          index_12 == otherIndex_12 ||
                          index_13 == otherIndex_13 ||
                          index_14 == otherIndex_14 ||
                          index_15 == otherIndex_15 ||
                          index_16 == otherIndex_16 ||
                          index_17 == otherIndex_17 ||
                          index_18 == otherIndex_18 ||
                          index_19 == otherIndex_19 ||
                          index_20 == otherIndex_20 ||
                          index_21 == otherIndex_21 ||
                          index_22 == otherIndex_22 ||
                          index_23 == otherIndex_23 ||
                          index_24 == otherIndex_24 ||
                          index_25 == otherIndex_25 ||
                          index_26 == otherIndex_26 ||
                          index_27 == otherIndex_27 ||
                          index_28 == otherIndex_28 ||
                          index_29 == otherIndex_29 ||
                          index_30 == otherIndex_30 ||
                          index_31 == otherIndex_31 ||
                          index_32 == otherIndex_32 ||
                          index_33 == otherIndex_33 ||
                          index_41 == otherIndex_41 ||
                          index_42 == otherIndex_42 ||
                          index_43 == otherIndex_43 ||
                          index_44 == otherIndex_44 ||
                          index_45 == otherIndex_45 ||
                          index_46 == otherIndex_46 ||
                          index_47 == otherIndex_47 ||
                          index_48 == otherIndex_48 ||
                          index_49 == otherIndex_49 ||
                          index_50 == otherIndex_50 ||
                          index_51 == otherIndex_51
                      ? height! + 15
                      : height!,
              // : MediaQuery.of(context).size.width < 550
              //     ? height! - 10

              decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? Colors.blue.shade400
                      : Colors.white,
                  boxShadow: [
                    selectedIndex == index
                        ? BoxShadow(color: Colors.blue.shade200, blurRadius: 20)
                        : BoxShadow(color: Colors.black12, blurRadius: 20)
                  ]

                  //  borderRadius: BorderRadius.circular(10.0),
                  ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.white : Colors.black,
                    fontWeight:
                        index == 23 || index == 22 ? FontWeight.bold : null,
                    fontSize: index == 23 || index == 22
                        ? Adaptive.px(30)
                        : index == 51
                            ? Adaptive.px(10)
                            : Adaptive.px(25),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spacebuttonTile(int index, Function()? onTap, String text,
      double? height, double? width) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        print('enter');
        setState(() {
          //  myvalue = true;
        });
      },
      onHover: (event) {
        setState(() {
          selectedIndex = index;
        });
      },
      onExit: (event) {
        setState(() {
          setState(() {
            selectedIndex = 0;
          });
          //   myvalue = false;
        });
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          // padding: EdgeInsets.symmetric(
          //   horizontal: selectedIndex == index ? Adaptive.w(3) : Adaptive.w(),
          //   vertical: selectedIndex == index ? Adaptive.h(5) : Adaptive.h(4),
          // ),
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
          width: selectedIndex == index

              // ? MediaQuery.of(context).size.width <= 400
              ? width! + 13
              : width,
          // : Adaptive.w(19),
          height: selectedIndex == index
              ? height! + 15
              : MediaQuery.of(context).size.width < 550
                  ? height! - 10
                  : height! + 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)]),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: index == 51 ? 10 : 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  FlutterTts flutterTts = FlutterTts();

  void _submitText() {
    String text = _textEditingController.text;
    // Process the text here
    // ...
    // Clear the text field after submitting
    // _textEditingController.clear();
  }

  void _handleEnterButton() {
    _textEditingController.text += '\n';
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: _textEditingController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      //backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Stylus Keyboard'),
        actions: [
          _prefs == null
              ? const SizedBox()
              : _prefs!.getString('api_key') != null
                  ? IconButton(
                      icon: const Icon(Icons.key),
                      onPressed: () {
                        updateAPIkeyDialog(context);
                      },
                    )
                  : const SizedBox(),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookmarksScreen(
                    bookmarks: _bookmarkedItems,
                    hwberewbookmarks: _hebrewbookmarkedItems,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Listener(
        onPointerHover: (event) {
          setState(() {
            // selectedIndex = 0;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Adaptive.h(5)),

                //Text(screenWidth.toString()),

                Container(
                  // width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ]),
                  child: Center(
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onSubmitted: (value) {},
                      textDirection: selectedLanguge == 1
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      controller: _textEditingController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              r'[^\n]'), // Allow all characters except newline
                        ),
                      ],
                      style: TextStyle(fontSize: Adaptive.px(22)),
                      decoration: InputDecoration(
                          suffixIcon: isApiCall
                              ? Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.blue.shade900,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (_textEditingController
                                        .text.isNotEmpty) {
                                      if (selectedLanguge == 1) {
                                        tts.speak(_textEditingController.text);
                                      } else {
                                        if (_prefs!.getString('api_key') ==
                                            null) {
                                          checkAPikey(context);
                                        } else {
                                          if (_prefs!
                                              .getString('api_key')!
                                              .isEmpty) {
                                            checkAPikey(context);
                                          } else {
                                            _getAudioFromAPI(
                                                _textEditingController.text);
                                          }
                                        }
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.volume_up,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                          border: InputBorder.none,
                          hintTextDirection: selectedLanguge == 1
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          hintText:
                              selectedLanguge == 1 ? 'Type here..' : 'הקלד כאן',
                          contentPadding: const EdgeInsets.all(15)),
                      readOnly: true,
                    ),
                  ),
                ),
                SizedBox(height: Adaptive.h(3)),
                //  englishKeyboard(),

                Container(
                  height: Adaptive.h(6),
                  width: Adaptive.w(60),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      langaugeTile('English', 1),
                      langaugeTile('Hebrew', 2)
                    ],
                  ),
                ),
                SizedBox(height: Adaptive.h(5)),

                selectedLanguge == 1
                    ? englishKeyboard(screenHeight, screenWidth)
                    : hebrewyKeyboard(screenHeight, screenWidth),

                SizedBox(height: Adaptive.h(2)),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int selectedLanguge = 1;
  Widget langaugeTile(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguge = index;
          selectedIndex = 0;
          _textEditingController.clear();
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: Adaptive.h(6),
        width: Adaptive.w(30),
        decoration: BoxDecoration(
            color:
                selectedLanguge == index ? Colors.blue.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: selectedLanguge == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget englishKeyboard(double height, double width) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          checkTile(
            index: 41,
            onTap: () {
              _handleTextInput('1');
            },
            text: '1',
            height: height * 0.1,
            width: width * 0.08,
            index_41: 41,
            index_42: 42,
            index_1: 1,
            index_2: 2,
          ),
          checkTile(
            index: 42,
            onTap: () {
              _handleTextInput('2');
            },
            text: '2',
            height: height * 0.1,
            width: width * 0.08,
            index_41: 41,
            index_42: 42,
            index_43: 43,
            index_1: 1,
            index_2: 2,
            index_3: 3,
          ),
          checkTile(
              index: 43,
              onTap: () {
                _handleTextInput('3');
              },
              text: '3',
              height: height * 0.1,
              width: width * 0.08,
              index_2: 2,
              index_3: 3,
              index_4: 4,
              index_42: 42,
              index_43: 43,
              index_44: 44),
          checkTile(
              index: 44,
              onTap: () {
                _handleTextInput('4');
              },
              text: '4',
              height: height * 0.1,
              width: width * 0.08,
              index_3: 3,
              index_4: 4,
              index_5: 5,
              index_43: 43,
              index_44: 44,
              index_45: 45),
          checkTile(
              index: 45,
              onTap: () {
                _handleTextInput('5');
              },
              text: '5',
              height: height * 0.1,
              width: width * 0.08,
              index_4: 4,
              index_5: 5,
              index_6: 6,
              index_44: 44,
              index_45: 45,
              index_46: 46),
          checkTile(
              index: 46,
              onTap: () {
                _handleTextInput('6');
              },
              text: '6',
              height: height * 0.1,
              width: width * 0.08,
              index_5: 5,
              index_6: 6,
              index_7: 7,
              index_45: 45,
              index_46: 46,
              index_47: 47),
          checkTile(
              index: 47,
              onTap: () {
                _handleTextInput('7');
              },
              text: '7',
              height: height * 0.1,
              width: width * 0.08,
              index_6: 6,
              index_7: 7,
              index_8: 8,
              index_46: 46,
              index_47: 47,
              index_48: 48),
          checkTile(
              index: 48,
              onTap: () {
                _handleTextInput('8');
              },
              text: '8',
              height: height * 0.1,
              width: width * 0.08,
              index_7: 7,
              index_8: 8,
              index_9: 9,
              index_47: 47,
              index_48: 48,
              index_49: 49),
          checkTile(
              index: 49,
              onTap: () {
                _handleTextInput('9');
              },
              text: '9',
              height: height * 0.1,
              width: width * 0.08,
              index_8: 8,
              index_9: 9,
              index_10: 10,
              index_48: 48,
              index_49: 49,
              index_50: 50),
          checkTile(
              index: 50,
              onTap: () {
                _handleTextInput('0');
              },
              text: '0',
              height: height * 0.1,
              width: width * 0.08,
              index_11: 11,
              index_9: 9,
              index_10: 10,
              index_49: 49,
              index_50: 50,
              index_51: 51),
          checkTile(
              index: 51,
              onTap: () {
                _clearInput();
              },
              text: 'Clear',
              height: height * 0.1,
              width: width * 0.08,
              index_11: 11,
              index_10: 10,
              index_50: 50,
              index_51: 51),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          checkTile(
              index: 1,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'q' : 'Q');
              },
              text: isUpperCaseFalse ? 'q' : 'Q',
              height: height * 0.1,
              width: width * 0.08,
              index_1: 1,
              index_2: 2,
              index_12: 12,
              index_13: 13,
              index_41: 41,
              index_42: 42),
          checkTile(
              index: 2,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'w' : 'W');
              },
              text: isUpperCaseFalse ? 'w' : 'W',
              height: height * 0.1,
              width: width * 0.08,
              index_1: 1,
              index_2: 2,
              index_3: 3,
              index_12: 12,
              index_13: 13,
              index_14: 14,
              index_41: 41,
              index_42: 42,
              index_43: 43),
          checkTile(
              index: 3,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'e' : 'E');
              },
              text: isUpperCaseFalse ? 'e' : 'E',
              height: height * 0.1,
              width: width * 0.08,
              index_2: 2,
              index_3: 3,
              index_4: 4,
              index_13: 13,
              index_14: 14,
              index_15: 15,
              index_42: 42,
              index_43: 43,
              index_44: 44),
          checkTile(
              index: 4,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'r' : 'R');
              },
              text: isUpperCaseFalse ? 'r' : 'R',
              height: height * 0.1,
              width: width * 0.08,
              index_3: 3,
              index_4: 4,
              index_5: 5,
              index_13: 13,
              index_14: 14,
              index_15: 15,
              index_16: 16,
              index_43: 43,
              index_44: 44,
              index_45: 45),
          checkTile(
              index: 5,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 't' : 'T');
              },
              text: isUpperCaseFalse ? 't' : 'T',
              height: height * 0.1,
              width: width * 0.08,
              index_4: 4,
              index_5: 5,
              index_6: 6,
              index_15: 15,
              index_16: 16,
              index_17: 17,
              index_44: 44,
              index_45: 45,
              index_46: 46),
          checkTile(
              index: 6,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'y' : 'Y');
              },
              text: isUpperCaseFalse ? 'y' : 'Y',
              height: height * 0.1,
              width: width * 0.08,
              index_5: 5,
              index_6: 6,
              index_7: 7,
              index_16: 16,
              index_17: 17,
              index_18: 18,
              index_45: 45,
              index_46: 46,
              index_47: 47),
          checkTile(
              index: 7,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'u' : 'U');
              },
              text: isUpperCaseFalse ? 'u' : 'U',
              height: height * 0.1,
              width: width * 0.08,
              index_6: 6,
              index_7: 7,
              index_8: 8,
              index_17: 17,
              index_18: 18,
              index_19: 19,
              index_46: 46,
              index_47: 47,
              index_48: 48),
          checkTile(
              index: 8,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'i' : 'I');
              },
              text: isUpperCaseFalse ? 'i' : 'I',
              height: height * 0.1,
              width: width * 0.08,
              index_7: 7,
              index_8: 8,
              index_9: 9,
              index_18: 18,
              index_19: 19,
              index_20: 20,
              index_47: 47,
              index_48: 48,
              index_49: 49),
          checkTile(
              index: 9,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'o' : 'O');
              },
              text: isUpperCaseFalse ? 'o' : 'O',
              height: height * 0.1,
              width: width * 0.08,
              index_8: 8,
              index_9: 9,
              index_10: 10,
              index_19: 19,
              index_20: 20,
              index_21: 21,
              index_48: 48,
              index_49: 49,
              index_50: 50),
          checkTile(
              index: 10,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'p' : 'P');
              },
              text: isUpperCaseFalse ? 'p' : 'P',
              height: height * 0.1,
              width: width * 0.08,
              index_9: 9,
              index_10: 10,
              index_11: 11,
              index_20: 20,
              index_21: 21,
              index_22: 22,
              index_49: 49,
              index_50: 50,
              index_51: 51),
          checkTile(
              index: 11,
              onTap: () {
                removeLastCharater();
              },
              text: '✖',
              height: height * 0.1,
              width: width * 0.08,
              index_10: 10,
              index_11: 11,
              index_21: 21,
              index_22: 22,
              index_50: 50,
              index_51: 51),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          checkTile(
            index: 12,
            onTap: () {
              _handleTextInput('?');
            },
            text: '?',
            height: height * 0.1,
            width: width * 0.08,
            index_1: 1,
            index_2: 2,
            index_12: 12,
            index_13: 13,
            index_23: 23,
            index_24: 24,
          ),
          checkTile(
              index: 13,
              onTap: () {
                _handleTextInput(isUpperCaseFalse ? 'a' : 'A');
              },
              text: isUpperCaseFalse ? 'a' : 'A',
              height: height * 0.1,
              width: width * 0.08,
              index_1: 1,
              index_2: 2,
              index_3: 3,
              index_12: 12,
              index_13: 13,
              index_14: 14,
              index_23: 23,
              index_24: 24,
              index_25: 25),
          checkTile(
            index: 14,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 's' : 'S');
            },
            text: isUpperCaseFalse ? 's' : 'S',
            height: height * 0.1,
            width: width * 0.08,
            index_2: 2,
            index_3: 3,
            index_4: 4,
            index_13: 13,
            index_14: 14,
            index_15: 15,
            index_24: 24,
            index_25: 25,
            index_26: 26,
          ),
          checkTile(
            index: 15,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'd' : 'D');
            },
            text: isUpperCaseFalse ? 'd' : 'D',
            height: height * 0.1,
            width: width * 0.08,
            index_3: 3,
            index_4: 4,
            index_5: 5,
            index_14: 14,
            index_15: 15,
            index_16: 16,
            index_25: 25,
            index_26: 26,
            index_27: 27,
          ),
          checkTile(
            index: 16,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'f' : 'F');
            },
            text: isUpperCaseFalse ? 'f' : 'F',
            height: height * 0.1,
            width: width * 0.08,
            index_4: 4,
            index_5: 5,
            index_6: 6,
            index_15: 15,
            index_16: 16,
            index_17: 17,
            index_26: 26,
            index_27: 27,
            index_28: 28,
          ),
          checkTile(
            index: 17,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'g' : 'G');
            },
            text: isUpperCaseFalse ? 'g' : 'G',
            height: height * 0.1,
            width: width * 0.08,
            index_5: 5,
            index_6: 6,
            index_7: 7,
            index_16: 16,
            index_17: 17,
            index_18: 18,
            index_27: 27,
            index_28: 28,
            index_29: 29,
          ),
          checkTile(
            index: 18,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'h' : 'H');
            },
            text: isUpperCaseFalse ? 'h' : 'H',
            height: height * 0.1,
            width: width * 0.08,
            index_6: 6,
            index_7: 7,
            index_8: 8,
            index_17: 17,
            index_18: 18,
            index_19: 19,
            index_28: 28,
            index_29: 29,
            index_30: 30,
          ),
          checkTile(
            index: 19,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'j' : 'J');
            },
            text: isUpperCaseFalse ? 'j' : 'J',
            height: height * 0.1,
            width: width * 0.08,
            index_7: 7,
            index_8: 8,
            index_9: 9,
            index_18: 18,
            index_19: 19,
            index_20: 20,
            index_29: 29,
            index_30: 30,
            index_31: 31,
          ),
          checkTile(
            index: 20,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'k' : 'K');
            },
            text: isUpperCaseFalse ? 'k' : 'K',
            height: height * 0.1,
            width: width * 0.08,
            index_8: 8,
            index_9: 9,
            index_10: 10,
            index_19: 19,
            index_20: 20,
            index_21: 21,
            index_30: 30,
            index_31: 31,
            index_32: 32,
          ),
          checkTile(
            index: 21,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'l' : 'L');
            },
            text: isUpperCaseFalse ? 'l' : 'L',
            height: height * 0.1,
            width: width * 0.08,
            index_9: 9,
            index_10: 10,
            index_11: 11,
            index_20: 20,
            index_21: 21,
            index_22: 22,
            index_31: 31,
            index_32: 32,
            index_33: 33,
          ),
          checkTile(
            index: 22,
            onTap: () {
              _handleEnterButton();
            },
            text: '↵',
            height: height * 0.1,
            width: width * 0.08,
            index_10: 10,
            index_11: 11,
            index_21: 21,
            index_22: 22,
            index_32: 32,
            index_33: 33,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          checkTile(
            index: 23,
            onTap: () {
              changeWord();
            },
            text: '⇧',
            height: height * 0.1,
            width: width * 0.08,
            index_12: 12,
            index_13: 13,
            index_23: 23,
            index_24: 24,
          ),
          checkTile(
            index: 24,
            onTap: () {
              _handleTextInput("'");
            },
            text: "'",
            height: height * 0.1,
            width: width * 0.08,
            index_12: 12,
            index_13: 13,
            index_14: 14,
            index_23: 23,
            index_24: 24,
            index_25: 25,
          ),
          checkTile(
            index: 25,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'z' : 'Z');
            },
            text: isUpperCaseFalse ? 'z' : 'Z',
            height: height * 0.1,
            width: width * 0.08,
            index_13: 13,
            index_14: 14,
            index_15: 15,
            index_24: 24,
            index_25: 25,
            index_26: 26,
          ),
          checkTile(
            index: 26,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'x' : 'X');
            },
            text: isUpperCaseFalse ? 'x' : 'X',
            height: height * 0.1,
            width: width * 0.08,
            index_14: 14,
            index_15: 15,
            index_16: 16,
            index_25: 25,
            index_26: 26,
            index_27: 27,
          ),
          checkTile(
            index: 27,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'c' : 'C');
            },
            text: isUpperCaseFalse ? 'c' : 'C',
            height: height * 0.1,
            width: width * 0.08,
            index_15: 15,
            index_16: 16,
            index_17: 17,
            index_26: 26,
            index_27: 27,
            index_28: 28,
          ),
          checkTile(
            index: 28,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'v' : 'V');
            },
            text: isUpperCaseFalse ? 'v' : 'V',
            height: height * 0.1,
            width: width * 0.08,
            index_16: 16,
            index_17: 17,
            index_18: 18,
            index_27: 27,
            index_28: 28,
            index_29: 29,
          ),
          checkTile(
            index: 29,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'b' : 'B');
            },
            text: isUpperCaseFalse ? 'b' : 'B',
            height: height * 0.1,
            width: width * 0.08,
            index_17: 17,
            index_18: 18,
            index_19: 19,
            index_28: 28,
            index_29: 29,
            index_30: 30,
          ),
          checkTile(
            index: 30,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'n' : 'N');
            },
            text: isUpperCaseFalse ? 'n' : 'N',
            height: height * 0.1,
            width: width * 0.08,
            index_18: 18,
            index_19: 19,
            index_20: 20,
            index_29: 29,
            index_30: 30,
            index_31: 31,
          ),
          checkTile(
            index: 31,
            onTap: () {
              _handleTextInput(isUpperCaseFalse ? 'm' : 'M');
            },
            text: isUpperCaseFalse ? 'm' : 'M',
            height: height * 0.1,
            width: width * 0.08,
            index_19: 19,
            index_20: 20,
            index_21: 21,
            index_30: 30,
            index_31: 31,
            index_32: 32,
          ),
          checkTile(
            index: 32,
            onTap: () {
              _handleTextInput('.');
            },
            text: '.',
            height: height * 0.1,
            width: width * 0.08,
            index_20: 20,
            index_21: 21,
            index_22: 22,
            index_31: 31,
            index_32: 32,
            index_33: 33,
          ),
          checkTile(
            index: 33,
            onTap: () {
              _handleTextInput(',');
            },
            text: ',',
            height: height * 0.1,
            width: width * 0.08,
            index_21: 21,
            index_22: 22,
            index_32: 32,
            index_33: 33,
          ),
        ]),
        SizedBox(
          height: Adaptive.h(0.5),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          checkTile(
            index: 34,
            onTap: () {
              _addBookmark(_textEditingController.text);
            },
            text: '☆',
            height: height * 0.1,
            width: width * 0.08,
          ),
          spacebuttonTile(35, () {
            _handleTextInput(' ');
          }, 'Space', height * 0.1, width * 0.6),
          SizedBox()
        ]),
      ],
    );
  }

  Widget hebrewyKeyboard(double height, double width) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        checkTile(
          index: 41,
          onTap: () {
            _handleTextInput('1');
          },
          text: '1',
          height: height * 0.1,
          width: width * 0.08,
          index_41: 41,
          index_42: 42,
          index_1: 1,
          index_2: 2,
        ),
        checkTile(
          index: 42,
          onTap: () {
            _handleTextInput('2');
          },
          text: '2',
          height: height * 0.1,
          width: width * 0.08,
          index_41: 41,
          index_42: 42,
          index_43: 43,
          index_1: 1,
          index_2: 2,
          index_3: 3,
        ),
        checkTile(
            index: 43,
            onTap: () {
              _handleTextInput('3');
            },
            text: '3',
            height: height * 0.1,
            width: width * 0.08,
            index_2: 2,
            index_3: 3,
            index_4: 4,
            index_42: 42,
            index_43: 43,
            index_44: 44),
        checkTile(
            index: 44,
            onTap: () {
              _handleTextInput('4');
            },
            text: '4',
            height: height * 0.1,
            width: width * 0.08,
            index_3: 3,
            index_4: 4,
            index_5: 5,
            index_43: 43,
            index_44: 44,
            index_45: 45),
        checkTile(
            index: 45,
            onTap: () {
              _handleTextInput('5');
            },
            text: '5',
            height: height * 0.1,
            width: width * 0.08,
            index_4: 4,
            index_5: 5,
            index_6: 6,
            index_44: 44,
            index_45: 45,
            index_46: 46),
        checkTile(
            index: 46,
            onTap: () {
              _handleTextInput('6');
            },
            text: '6',
            height: height * 0.1,
            width: width * 0.08,
            index_5: 5,
            index_6: 6,
            index_7: 7,
            index_45: 45,
            index_46: 46,
            index_47: 47),
        checkTile(
            index: 47,
            onTap: () {
              _handleTextInput('7');
            },
            text: '7',
            height: height * 0.1,
            width: width * 0.08,
            index_6: 6,
            index_7: 7,
            index_8: 8,
            index_46: 46,
            index_47: 47,
            index_48: 48),
        checkTile(
            index: 48,
            onTap: () {
              _handleTextInput('8');
            },
            text: '8',
            height: height * 0.1,
            width: width * 0.08,
            index_7: 7,
            index_8: 8,
            index_9: 9,
            index_47: 47,
            index_48: 48,
            index_49: 49),
        checkTile(
            index: 49,
            onTap: () {
              _handleTextInput('9');
            },
            text: '9',
            height: height * 0.1,
            width: width * 0.08,
            index_8: 8,
            index_9: 9,
            index_10: 10,
            index_48: 48,
            index_49: 49,
            index_50: 50),
        checkTile(
            index: 50,
            onTap: () {
              _handleTextInput('0');
            },
            text: '0',
            height: height * 0.1,
            width: width * 0.08,
            index_11: 11,
            index_9: 9,
            index_10: 10,
            index_49: 49,
            index_50: 50,
            index_51: 51),

        checkTile(
            index: 51,
            onTap: () {
              _clearInput();
            },
            text: 'נקה',
            height: height * 0.1,
            width: width * 0.08,
            index_11: 11,
            index_10: 10,
            index_50: 50,
            index_51: 51),

        // checkTile(51, () {
        //   //    setdsa();
        //   // txtToSpeach();
        //   _clearInput();
        // }, 'נקה', height * 0.1, width * 0.08, 1, 11),
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          checkTile(
              index: 1,
              onTap: () {
                _handleTextInput(',');
              },
              text: ',',
              height: height * 0.1,
              width: width * 0.08,
              index_1: 1,
              index_2: 2,
              index_12: 12,
              index_13: 13,
              index_41: 41,
              index_42: 42),
          checkTile(
              index: 2,
              onTap: () {
                _handleTextInput("'");
              },
              text: "'",
              height: height * 0.1,
              width: width * 0.08,
              index_1: 1,
              index_2: 2,
              index_3: 3,
              index_12: 12,
              index_13: 13,
              index_14: 14,
              index_41: 41,
              index_42: 42,
              index_43: 43),
          checkTile(
              index: 3,
              onTap: () {
                _handleTextInput('ק');
              },
              text: 'ק',
              height: height * 0.1,
              width: width * 0.08,
              index_2: 2,
              index_3: 3,
              index_4: 4,
              index_13: 13,
              index_14: 14,
              index_15: 15,
              index_42: 42,
              index_43: 43,
              index_44: 44),
          checkTile(
              index: 4,
              onTap: () {
                _handleTextInput('ר');
              },
              text: 'ר',
              height: height * 0.1,
              width: width * 0.08,
              index_3: 3,
              index_4: 4,
              index_5: 5,
              index_13: 13,
              index_14: 14,
              index_15: 15,
              index_16: 16,
              index_43: 43,
              index_44: 44,
              index_45: 45),
          checkTile(
              index: 5,
              onTap: () {
                _handleTextInput('א');
              },
              text: 'א',
              height: height * 0.1,
              width: width * 0.08,
              index_4: 4,
              index_5: 5,
              index_6: 6,
              index_15: 15,
              index_16: 16,
              index_17: 17,
              index_44: 44,
              index_45: 45,
              index_46: 46),
          checkTile(
              index: 6,
              onTap: () {
                _handleTextInput('ט');
              },
              text: 'ט',
              height: height * 0.1,
              width: width * 0.08,
              index_5: 5,
              index_6: 6,
              index_7: 7,
              index_16: 16,
              index_17: 17,
              index_18: 18,
              index_45: 45,
              index_46: 46,
              index_47: 47),
          checkTile(
              index: 7,
              onTap: () {
                _handleTextInput('ו');
              },
              text: 'ו',
              height: height * 0.1,
              width: width * 0.08,
              index_6: 6,
              index_7: 7,
              index_8: 8,
              index_17: 17,
              index_18: 18,
              index_19: 19,
              index_46: 46,
              index_47: 47,
              index_48: 48),
          checkTile(
              index: 8,
              onTap: () {
                _handleTextInput('ן');
              },
              text: 'ן',
              height: height * 0.1,
              width: width * 0.08,
              index_7: 7,
              index_8: 8,
              index_9: 9,
              index_18: 18,
              index_19: 19,
              index_20: 20,
              index_47: 47,
              index_48: 48,
              index_49: 49),
          checkTile(
              index: 9,
              onTap: () {
                _handleTextInput('ם');
              },
              text: 'ם',
              height: height * 0.1,
              width: width * 0.08,
              index_8: 8,
              index_9: 9,
              index_10: 10,
              index_19: 19,
              index_20: 20,
              index_21: 21,
              index_48: 48,
              index_49: 49,
              index_50: 50),
          checkTile(
              index: 10,
              onTap: () {
                _handleTextInput('פ');
              },
              text: 'פ',
              height: height * 0.1,
              width: width * 0.08,
              index_9: 9,
              index_10: 10,
              index_11: 11,
              index_20: 20,
              index_21: 21,
              index_22: 22,
              index_49: 49,
              index_50: 50,
              index_51: 51),
          checkTile(
              index: 11,
              onTap: () {
                removeLastCharater();
              },
              text: '✖',
              height: height * 0.1,
              width: width * 0.08,
              index_10: 10,
              index_11: 11,
              index_21: 21,
              index_22: 22,
              index_50: 50,
              index_51: 51),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        checkTile(
          index: 12,
          onTap: () {
            _handleTextInput('ש');
          },
          text: 'ש',
          height: height * 0.1,
          width: width * 0.08,
          index_1: 1,
          index_2: 2,
          index_12: 12,
          index_13: 13,
          index_23: 23,
          index_24: 24,
        ),
        checkTile(
            index: 13,
            onTap: () {
              _handleTextInput("ד");
            },
            text: "ד",
            height: height * 0.1,
            width: width * 0.08,
            index_1: 1,
            index_2: 2,
            index_3: 3,
            index_12: 12,
            index_13: 13,
            index_14: 14,
            index_23: 23,
            index_24: 24,
            index_25: 25),
        checkTile(
          index: 14,
          onTap: () {
            _handleTextInput("ג");
          },
          text: "ג",
          height: height * 0.1,
          width: width * 0.08,
          index_2: 2,
          index_3: 3,
          index_4: 4,
          index_13: 13,
          index_14: 14,
          index_15: 15,
          index_24: 24,
          index_25: 25,
          index_26: 26,
        ),
        checkTile(
          index: 15,
          onTap: () {
            _handleTextInput("כ");
          },
          text: "כ",
          height: height * 0.1,
          width: width * 0.08,
          index_3: 3,
          index_4: 4,
          index_5: 5,
          index_14: 14,
          index_15: 15,
          index_16: 16,
          index_25: 25,
          index_26: 26,
          index_27: 27,
        ),
        checkTile(
          index: 16,
          onTap: () {
            _handleTextInput("ע");
          },
          text: "ע",
          height: height * 0.1,
          width: width * 0.08,
          index_4: 4,
          index_5: 5,
          index_6: 6,
          index_15: 15,
          index_16: 16,
          index_17: 17,
          index_26: 26,
          index_27: 27,
          index_28: 28,
        ),
        checkTile(
          index: 17,
          onTap: () {
            _handleTextInput("י");
          },
          text: "י",
          height: height * 0.1,
          width: width * 0.08,
          index_5: 5,
          index_6: 6,
          index_7: 7,
          index_16: 16,
          index_17: 17,
          index_18: 18,
          index_27: 27,
          index_28: 28,
          index_29: 29,
        ),
        checkTile(
          index: 18,
          onTap: () {
            _handleTextInput("ח");
          },
          text: "ח",
          height: height * 0.1,
          width: width * 0.08,
          index_6: 6,
          index_7: 7,
          index_8: 8,
          index_17: 17,
          index_18: 18,
          index_19: 19,
          index_28: 28,
          index_29: 29,
          index_30: 30,
        ),
        checkTile(
          index: 19,
          onTap: () {
            _handleTextInput("ל");
          },
          text: "ל",
          height: height * 0.1,
          width: width * 0.08,
          index_7: 7,
          index_8: 8,
          index_9: 9,
          index_18: 18,
          index_19: 19,
          index_20: 20,
          index_29: 29,
          index_30: 30,
          index_31: 31,
        ),
        checkTile(
          index: 20,
          onTap: () {
            _handleTextInput("ך");
          },
          text: "ך",
          height: height * 0.1,
          width: width * 0.08,
          index_8: 8,
          index_9: 9,
          index_10: 10,
          index_19: 19,
          index_20: 20,
          index_21: 21,
          index_30: 30,
          index_31: 31,
          index_32: 32,
        ),
        checkTile(
          index: 21,
          onTap: () {
            _handleTextInput('ף');
          },
          text: 'ף',
          height: height * 0.1,
          width: width * 0.08,
          index_9: 9,
          index_10: 10,
          index_11: 11,
          index_20: 20,
          index_21: 21,
          index_22: 22,
          index_31: 31,
          index_32: 32,
          index_33: 33,
        ),
        checkTile(
          index: 22,
          onTap: () {
            _handleEnterButton();
          },
          text: '↵',
          height: height * 0.1,
          width: width * 0.08,
          index_10: 10,
          index_11: 11,
          index_21: 21,
          index_22: 22,
          index_32: 32,
          index_33: 33,
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        checkTile(
          index: 23,
          onTap: () {
            _handleTextInput('?');
          },
          text: '?',
          height: height * 0.1,
          width: width * 0.08,
          index_12: 12,
          index_13: 13,
          index_23: 23,
          index_24: 24,
        ),
        checkTile(
          index: 24,
          onTap: () {
            _handleTextInput("ז");
          },
          text: "ז",
          height: height * 0.1,
          width: width * 0.08,
          index_12: 12,
          index_13: 13,
          index_14: 14,
          index_23: 23,
          index_24: 24,
          index_25: 25,
        ),
        checkTile(
          index: 25,
          onTap: () {
            _handleTextInput("ס");
          },
          text: "ס",
          height: height * 0.1,
          width: width * 0.08,
          index_13: 13,
          index_14: 14,
          index_15: 15,
          index_24: 24,
          index_25: 25,
          index_26: 26,
        ),
        checkTile(
          index: 26,
          onTap: () {
            _handleTextInput("ב");
          },
          text: "ב",
          height: height * 0.1,
          width: width * 0.08,
          index_14: 14,
          index_15: 15,
          index_16: 16,
          index_25: 25,
          index_26: 26,
          index_27: 27,
        ),
        checkTile(
          index: 27,
          onTap: () {
            _handleTextInput("ה");
          },
          text: "ה",
          height: height * 0.1,
          width: width * 0.08,
          index_15: 15,
          index_16: 16,
          index_17: 17,
          index_26: 26,
          index_27: 27,
          index_28: 28,
        ),
        checkTile(
          index: 28,
          onTap: () {
            _handleTextInput("נ");
          },
          text: "נ",
          height: height * 0.1,
          width: width * 0.08,
          index_16: 16,
          index_17: 17,
          index_18: 18,
          index_27: 27,
          index_28: 28,
          index_29: 29,
        ),
        checkTile(
          index: 29,
          onTap: () {
            _handleTextInput("מ");
          },
          text: "מ",
          height: height * 0.1,
          width: width * 0.08,
          index_17: 17,
          index_18: 18,
          index_19: 19,
          index_28: 28,
          index_29: 29,
          index_30: 30,
        ),
        checkTile(
          index: 30,
          onTap: () {
            _handleTextInput("צ");
          },
          text: "צ",
          height: height * 0.1,
          width: width * 0.08,
          index_18: 18,
          index_19: 19,
          index_20: 20,
          index_29: 29,
          index_30: 30,
          index_31: 31,
        ),
        checkTile(
          index: 31,
          onTap: () {
            _handleTextInput('ת');
          },
          text: 'ת',
          height: height * 0.1,
          width: width * 0.08,
          index_19: 19,
          index_20: 20,
          index_21: 21,
          index_30: 30,
          index_31: 31,
          index_32: 32,
        ),
        checkTile(
          index: 32,
          onTap: () {
            _handleTextInput('ץ');
          },
          text: 'ץ',
          height: height * 0.1,
          width: width * 0.08,
          index_20: 20,
          index_21: 21,
          index_22: 22,
          index_31: 31,
          index_32: 32,
          index_33: 33,
        ),
        checkTile(
          index: 33,
          onTap: () {
            _handleTextInput('.');
          },
          text: '.',
          height: height * 0.1,
          width: width * 0.08,
          index_21: 21,
          index_22: 22,
          index_32: 32,
          index_33: 33,
        ),
      ]),

      SizedBox(
        height: Adaptive.h(0.5),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        checkTile(
          index: 34,
          onTap: () {
            _addBookmark(_textEditingController.text);
          },
          text: '☆',
          height: height * 0.1,
          width: width * 0.08,
        ),
        spacebuttonTile(35, () {
          _handleTextInput(' ');
        }, 'רווח', height * 0.1, width * 0.6),
        SizedBox()
      ]),
      //     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //       checkTile(34, () {
      //         _addBookmark(_textEditingController.text);
      //       }, '☆', height * 0.1, width * 0.08, 5, 1),
      //       spacebuttonTile(35, () {
      //         _handleTextInput(' ');
      //       }, 'רווח', height * 0.1, width * 0.6),
      //       SizedBox()
      //     ]),
      //     // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      //     //   contianerTile(1, () {
      //     //     // setdsa();
      //     //     // txtToSpeach();
      //     //     _clearInput();
      //     //   }, 'נקה'),
      //     //   contianerTile(2, () {
      //     //     _handleTextInput('א');
      //     //   }, 'א'),
      //     //   contianerTile(3, () {
      //     //     _handleTextInput('ב');
      //     //   }, 'ב'),
      //     //   contianerTile(4, () {
      //     //     _handleTextInput('ג');
      //     //   }, 'ג'),
      //     //   contianerTile(5, () {
      //     //     _handleTextInput('ד');
      //     //   }, 'ד'),
      //     // ]),
      //     // SizedBox(height: Adaptive.h(1.5)),
      //     // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      //     //   contianerTile(6, () {
      //     //     _handleTextInput('ה');
      //     //   }, 'ה'),
      //     //   contianerTile(7, () {
      //     //     _handleTextInput('ו');
      //     //   }, 'ו'),
      //     //   contianerTile(8, () {
      //     //     _handleTextInput('ז');
      //     //   }, 'ז'),
      //     //   contianerTile(9, () {
      //     //     _handleTextInput('ח');
      //     //   }, 'ח'),
      //     //   contianerTile(10, () {
      //     //     _handleTextInput('ט');
      //     //   }, 'ט'),
      //     // ]),
      //     // SizedBox(height: Adaptive.h(2)),
      //     // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      //     //   contianerTile(11, () {
      //     //     _handleTextInput('י');
      //     //   }, 'י'),
      //     //   contianerTile(12, () {
      //     //     _handleTextInput('כ');
      //     //   }, 'כ'),
      //     //   contianerTile(13, () {
      //     //     _handleTextInput('ל');
      //     //   }, 'ל'),
      //     //   contianerTile(14, () {
      //     //     _handleTextInput('מ');
      //     //   }, 'מ'),
      //     //   contianerTile(15, () {
      //     //     _handleTextInput('נ');
      //     //   }, 'נ'),
      //     // ]),
      //     // SizedBox(height: Adaptive.h(1.5)),
      //     // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      //     //   contianerTile(16, () {
      //     //     _handleTextInput('ס');
      //     //   }, 'ס'),
      //     //   contianerTile(17, () {
      //     //     _handleTextInput('ע');
      //     //   }, 'ע'),
      //     //   contianerTile(18, () {
      //     //     _handleTextInput('פ');
      //     //   }, 'פ'),
      //     //   contianerTile(19, () {
      //     //     _handleTextInput('צ');
      //     //   }, 'צ'),
      //     //   contianerTile(20, () {
      //     //     _handleTextInput('ק');
      //     //   }, 'ק'),
      //     // ]),
      //     // SizedBox(height: Adaptive.h(1.5)),
      //     // Row(
      //     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     //   children: [
      //     //     contianerTile(21, () {
      //     //       _handleTextInput('ר');
      //     //     }, 'ר'),
      //     //     contianerTile(22, () {
      //     //       _handleTextInput('ש');
      //     //     }, 'ש'),
      //     //     contianerTile(23, () {
      //     //       _handleTextInput('ת');
      //     //     }, 'ת'),
      //     //     contianerTile(24, () {
      //     //       _handleTextInput('ם');
      //     //     }, 'ם'),
      //     //     contianerTile(25, () {
      //     //       _handleTextInput('ך ');
      //     //     }, 'ך'),
      //     //   ],
      //     // ),
      //     // SizedBox(height: Adaptive.h(1.5)),
      //     // Row(
      //     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     //   children: [
      //     //     contianerTile(26, () {
      //     //       _handleTextInput('ץ');
      //     //     }, 'ץ'),
      //     //     contianerTile(27, () {
      //     //       _handleTextInput('ף');
      //     //     }, 'ף'),
      //     //     contianerTile(28, () {
      //     //       _addBookmark(_textEditingController.text);
      //     //     }, 'סמן\nעמוד'),
      //     //     contianerTile(29, () {
      //     //       _handleTextInput('.');
      //     //     }, '.'),
      //     //     contianerTile(30, () {
      //     //       _handleTextInput(',');
      //     //     }, ','),
      //     //   ],
      //     // ),
      //     // SizedBox(height: Adaptive.h(2)),
      //     // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //     //   contianerTile(31, () {
      //     //     _handleTextInput('?');
      //     //   }, '?'),
      //     //   contianerTile(32, () {
      //     //     _handleTextInput(' ');
      //     //   }, 'רווח'),
      //     // ]),
    ]);
  }

  TextEditingController apikey = TextEditingController();

  void dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter you API KEY"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: apikey,
                decoration: InputDecoration(
                  labelText: "API KEY",
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (apikey.text.isNotEmpty) {
                  _prefs!.setString('api_key', apikey.text);
                  Navigator.of(context).pop(false);
                }
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void updateAPIkeyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your API KEY is : "),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_prefs!.getString('api_key').toString()),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Back"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                dialog(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void checkAPikey(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "You need to enter API KEY to use this feature",
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                    dialog(context);
                  },
                  child: Text('Enter API KEY ')),
              TextButton(
                  onPressed: () {
                    launchURL(
                        "https://auth.narakeet.com/signup?code_challenge_method=S256&code_challenge=sh50M6adaBcA_GMOKT3_NBm2Rm7AKDDnhZsa0W3nTfE&response_type=code&scope=openid+profile+aws.cognito.signin.user.admin&client_id=70femm5nel95cgf8l546ddmgqg&redirect_uri=https%3A%2F%2Fwww.narakeet.com%2Fauth%2Fopenid%2F&state=r%3A1W9BaVkkLj");
                  },
                  child: Text('Generate API KEY '))
            ],
          ),
        );
      },
    );
  }
}
