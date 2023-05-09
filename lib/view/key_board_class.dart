import 'package:flutter/material.dart';
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
                'x-api-key': apiKey, //_prefs!.getString('api_key')!,
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
        Get.snackbar('Failed', 'Enter valid sentance or word',
            colorText: Colors.white);
      } else if (response.statusCode == 403) {
        log('--------------');
        setState(() {
          isApiCall = false;
        });
        Get.snackbar(
            'Failed', 'Your Api key is not correct or maybe its expire',
            colorText: Colors.white);
      } else {
        setState(() {
          isApiCall = false;
        });
        Get.snackbar(
            'Failed', 'Your Api key is not correct or maybe its expire',
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

  bool _isHovering = false;
  int selectedIndex = 0;
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

  Widget checkTile(int index, Function()? onTap, String text, double? height,
      double? width) {
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
              ? width! + 20
              : width,
          // : Adaptive.w(19),
          height: selectedIndex == index ? height! + 18 : height,
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
                fontSize: index == 1 ? 10 : 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    double scwidth = MediaQuery.of(context).size.width;
    double schifh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Stylus Keyboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
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
      body:
          //
          Listener(
        onPointerHover: (event) {
          setState(() {
            // selectedIndex = 0;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('screen wit $scwidth'),

                Container(
                  height: schifh * 0.1,
                  width: scwidth * 0.1,
                  color: Colors.amber,
                ),
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
                      textDirection: selectedLanguge == 1
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      controller: _textEditingController,
                      style: TextStyle(fontSize: Adaptive.px(22)),
                      decoration: InputDecoration(
                          suffixIcon: isApiCall
                              ? const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
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
                                  child: const Icon(
                                    Icons.volume_up,
                                    color: Colors.black,
                                  ),
                                ),
                          border: InputBorder.none,
                          hintTextDirection: selectedLanguge == 1
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          hintText:
                              selectedLanguge == 1 ? 'Type here..' : 'הקלד כאן',
                          contentPadding: EdgeInsets.all(15)),
                      readOnly: true,
                    ),
                  ),
                ),
                SizedBox(height: Adaptive.h(2)),
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
                SizedBox(height: Adaptive.h(2)),

                selectedLanguge == 1
                    ? englishKeyboard(schifh, scwidth)
                    : hebrewyKeyboard(),

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
            color: selectedLanguge == index ? Colors.black : Colors.white,
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
    return MediaQuery.of(context).size.width <= 400
        ? Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(1, () {
                  //    setdsa();
                  // txtToSpeach();
                  _clearInput();
                }, 'Clear'),
                contianerTile(2, () {
                  _handleTextInput('A');
                }, 'A'),
                contianerTile(3, () {
                  _handleTextInput('B');
                }, 'B'),
                contianerTile(4, () {
                  _handleTextInput('C');
                }, 'C'),
              ]),
              SizedBox(height: Adaptive.h(1.5)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(5, () {
                  _handleTextInput('D');
                }, 'D'),
                contianerTile(6, () {
                  _handleTextInput('E');
                }, 'E'),
                contianerTile(7, () {
                  _handleTextInput('F');
                }, 'F'),
                contianerTile(8, () {
                  _handleTextInput('G');
                }, 'G'),
              ]),
              SizedBox(height: Adaptive.h(2)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(9, () {
                  _handleTextInput('H');
                }, 'H'),
                contianerTile(10, () {
                  _handleTextInput('I');
                }, 'I'),
                contianerTile(11, () {
                  _handleTextInput('J');
                }, 'J'),
                contianerTile(12, () {
                  _handleTextInput('K');
                }, 'K'),
              ]),
              SizedBox(height: Adaptive.h(1.5)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(13, () {
                  _handleTextInput('L');
                }, 'L'),
                contianerTile(14, () {
                  _handleTextInput('M');
                }, 'M'),
                contianerTile(15, () {
                  _handleTextInput('N');
                }, 'N'),
                contianerTile(16, () {
                  _handleTextInput('O');
                }, 'O'),
              ]),
              SizedBox(height: Adaptive.h(1.5)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(17, () {
                  _handleTextInput('P');
                }, 'P'),
                contianerTile(18, () {
                  _handleTextInput('Q');
                }, 'Q'),
                contianerTile(19, () {
                  _handleTextInput('R');
                }, 'R'),
                contianerTile(20, () {
                  _handleTextInput('S');
                }, 'S'),
              ]),
              SizedBox(height: Adaptive.h(1.5)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(21, () {
                  _handleTextInput('T');
                }, 'T'),
                contianerTile(22, () {
                  _handleTextInput('U');
                }, 'U'),
                contianerTile(23, () {
                  _handleTextInput('V');
                }, 'V'),
                contianerTile(24, () {
                  _handleTextInput('W');
                }, 'W'),
              ]),
              SizedBox(height: Adaptive.h(1.5)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(25, () {
                  _handleTextInput('X');
                }, 'X'),
                contianerTile(26, () {
                  _handleTextInput('Y');
                }, 'Y'),
                contianerTile(27, () {
                  _handleTextInput('z');
                }, 'Z'),
                contianerTile(32, () {
                  _handleTextInput(' ');
                }, 'Space'),
              ]),
              SizedBox(height: Adaptive.h(1.5)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                contianerTile(29, () {
                  _handleTextInput('.');
                }, '.'),
                contianerTile(30, () {
                  _handleTextInput(',');
                }, ','),
                contianerTile(31, () {
                  _handleTextInput('?');
                }, '?'),
                contianerTile(28, () {
                  _addBookmark(_textEditingController.text);
                }, 'Book\nmark'),
              ]),
            ],
          )
        : Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                checkTile(41, () {
                  _handleTextInput('1');
                }, '1', height * 0.1, width * 0.08),
                checkTile(42, () {
                  _handleTextInput('2');
                }, '2', height * 0.1, width * 0.08),
                checkTile(43, () {
                  _handleTextInput('3');
                }, '3', height * 0.1, width * 0.08),
                checkTile(44, () {
                  _handleTextInput('4');
                }, '4', height * 0.1, width * 0.08),
                checkTile(45, () {
                  _handleTextInput('5');
                }, '5', height * 0.1, width * 0.08),
                checkTile(46, () {
                  _handleTextInput('6');
                }, '6', height * 0.1, width * 0.08),
                checkTile(47, () {
                  _handleTextInput('7');
                }, '7', height * 0.1, width * 0.08),
                checkTile(48, () {
                  _handleTextInput('8');
                }, '8', height * 0.1, width * 0.08),
                checkTile(49, () {
                  _handleTextInput('9');
                }, '9', height * 0.1, width * 0.08),
                checkTile(50, () {
                  _handleTextInput('0');
                }, '0', height * 0.1, width * 0.08),

                checkTile(1, () {
                  //    setdsa();
                  // txtToSpeach();
                  _clearInput();
                }, 'Clear', height * 0.1, width * 0.08),
                // contianerTile(1, () {
                //   //    setdsa();
                //   // txtToSpeach();
                //   _clearInput();
                // }, 'Clear'),
                // contianerTile(2, () {
                //   _handleTextInput('A');
                // }, 'A'),
                // contianerTile(3, () {
                //   _handleTextInput('B');
                // }, 'B'),
                // contianerTile(4, () {
                //   _handleTextInput('C');
                // }, 'C'),
                // contianerTile(5, () {
                //   _handleTextInput('D');
                // }, 'D'),
              ]),
              // SizedBox(height: Adaptive.h(1.5)),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //   contianerTile(6, () {
              //     _handleTextInput('E');
              //   }, 'E'),
              //   contianerTile(7, () {
              //     _handleTextInput('F');
              //   }, 'F'),
              //   contianerTile(8, () {
              //     _handleTextInput('G');
              //   }, 'G'),
              //   contianerTile(9, () {
              //     _handleTextInput('H');
              //   }, 'H'),
              //   contianerTile(10, () {
              //     _handleTextInput('I');
              //   }, 'I'),
              // ]),
              // SizedBox(height: Adaptive.h(2)),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //   contianerTile(11, () {
              //     _handleTextInput('J');
              //   }, 'J'),
              //   contianerTile(12, () {
              //     _handleTextInput('K');
              //   }, 'K'),
              //   contianerTile(13, () {
              //     _handleTextInput('L');
              //   }, 'L'),
              //   contianerTile(14, () {
              //     _handleTextInput('M');
              //   }, 'M'),
              //   contianerTile(15, () {
              //     _handleTextInput('N');
              //   }, 'N'),
              // ]),
              // SizedBox(height: Adaptive.h(1.5)),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //   contianerTile(16, () {
              //     _handleTextInput('O');
              //   }, 'O'),
              //   contianerTile(17, () {
              //     _handleTextInput('P');
              //   }, 'P'),
              //   contianerTile(18, () {
              //     _handleTextInput('Q');
              //   }, 'Q'),
              //   contianerTile(19, () {
              //     _handleTextInput('R');
              //   }, 'R'),
              //   contianerTile(20, () {
              //     _handleTextInput('S');
              //   }, 'S'),
              // ]),
              // SizedBox(height: Adaptive.h(1.5)),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //   contianerTile(21, () {
              //     _handleTextInput('T');
              //   }, 'T'),
              //   contianerTile(22, () {
              //     _handleTextInput('U');
              //   }, 'U'),
              //   contianerTile(23, () {
              //     _handleTextInput('V');
              //   }, 'V'),
              //   contianerTile(24, () {
              //     _handleTextInput('W');
              //   }, 'W'),
              //   contianerTile(25, () {
              //     _handleTextInput('X');
              //   }, 'X'),
              // ]),
              // SizedBox(height: Adaptive.h(1.5)),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //   contianerTile(26, () {
              //     _handleTextInput('Y');
              //   }, 'Y'),
              //   contianerTile(27, () {
              //     _handleTextInput('z');
              //   }, 'Z'),
              //   contianerTile(32, () {
              //     _handleTextInput(' ');
              //   }, 'Space'),
              //   contianerTile(29, () {
              //     _handleTextInput('.');
              //   }, '.'),
              //   contianerTile(30, () {
              //     _handleTextInput(',');
              //   }, ','),
              // ]),
              // SizedBox(height: Adaptive.h(1.5)),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   contianerTile(31, () {
              //     _handleTextInput('?');
              //   }, '?'),
              //   contianerTile(28, () {
              //     _addBookmark(_textEditingController.text);
              //   }, 'Book\nmark'),
              // ]),
              // SizedBox(height: Adaptive.h(1.5)),
              // // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

              // ]),
            ],
          );
  }

  Widget hebrewyKeyboard() {
    return MediaQuery.of(context).size.width <= 400
        ? Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(1, () {
                // setdsa();
                // txtToSpeach();
                _clearInput();
              }, 'נקה'),
              contianerTile(2, () {
                _handleTextInput('א');
              }, 'א'),
              contianerTile(3, () {
                _handleTextInput('ב');
              }, 'ב'),
              contianerTile(4, () {
                _handleTextInput('ג');
              }, 'ג'),
            ]),
            SizedBox(height: Adaptive.h(1.5)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(5, () {
                _handleTextInput('ד');
              }, 'ד'),
              contianerTile(6, () {
                _handleTextInput('ה');
              }, 'ה'),
              contianerTile(7, () {
                _handleTextInput('ו');
              }, 'ו'),
              contianerTile(8, () {
                _handleTextInput('ז');
              }, 'ז'),
            ]),
            SizedBox(height: Adaptive.h(2)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(9, () {
                _handleTextInput('ח');
              }, 'ח'),
              contianerTile(10, () {
                _handleTextInput('ט');
              }, 'ט'),
              contianerTile(11, () {
                _handleTextInput('י');
              }, 'י'),
              contianerTile(12, () {
                _handleTextInput('כ');
              }, 'כ'),
            ]),
            SizedBox(height: Adaptive.h(1.5)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(13, () {
                _handleTextInput('ל');
              }, 'ל'),
              contianerTile(14, () {
                _handleTextInput('מ');
              }, 'מ'),
              contianerTile(15, () {
                _handleTextInput('נ');
              }, 'נ'),
              contianerTile(16, () {
                _handleTextInput('ס');
              }, 'ס'),
            ]),
            SizedBox(height: Adaptive.h(1.5)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(17, () {
                _handleTextInput('ע');
              }, 'ע'),
              contianerTile(18, () {
                _handleTextInput('פ');
              }, 'פ'),
              contianerTile(19, () {
                _handleTextInput('צ');
              }, 'צ'),
              contianerTile(20, () {
                _handleTextInput('ק');
              }, 'ק'),
            ]),
            SizedBox(height: Adaptive.h(1.5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                contianerTile(21, () {
                  _handleTextInput('ר');
                }, 'ר'),
                contianerTile(22, () {
                  _handleTextInput('ש');
                }, 'ש'),
                contianerTile(23, () {
                  _handleTextInput('ת');
                }, 'ת'),
                contianerTile(24, () {
                  _handleTextInput('ם');
                }, 'ם'),
              ],
            ),
            SizedBox(height: Adaptive.h(1.5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                contianerTile(25, () {
                  _handleTextInput('ך ');
                }, 'ך'),
                contianerTile(26, () {
                  _handleTextInput('ץ');
                }, 'ץ'),
                contianerTile(27, () {
                  _handleTextInput('ף');
                }, 'ף'),
                contianerTile(28, () {
                  _addBookmark(_textEditingController.text);
                }, 'סמן\nעמוד'),
              ],
            ),
            SizedBox(height: Adaptive.h(2)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              contianerTile(29, () {
                _handleTextInput('.');
              }, '.'),
              contianerTile(30, () {
                _handleTextInput(',');
              }, ','),
              contianerTile(31, () {
                _handleTextInput('?');
              }, '?'),
              contianerTile(32, () {
                _handleTextInput(' ');
              }, 'רווח'),
            ]),
          ])
        : Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(1, () {
                // setdsa();
                // txtToSpeach();
                _clearInput();
              }, 'נקה'),
              contianerTile(2, () {
                _handleTextInput('א');
              }, 'א'),
              contianerTile(3, () {
                _handleTextInput('ב');
              }, 'ב'),
              contianerTile(4, () {
                _handleTextInput('ג');
              }, 'ג'),
              contianerTile(5, () {
                _handleTextInput('ד');
              }, 'ד'),
            ]),
            SizedBox(height: Adaptive.h(1.5)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(6, () {
                _handleTextInput('ה');
              }, 'ה'),
              contianerTile(7, () {
                _handleTextInput('ו');
              }, 'ו'),
              contianerTile(8, () {
                _handleTextInput('ז');
              }, 'ז'),
              contianerTile(9, () {
                _handleTextInput('ח');
              }, 'ח'),
              contianerTile(10, () {
                _handleTextInput('ט');
              }, 'ט'),
            ]),
            SizedBox(height: Adaptive.h(2)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(11, () {
                _handleTextInput('י');
              }, 'י'),
              contianerTile(12, () {
                _handleTextInput('כ');
              }, 'כ'),
              contianerTile(13, () {
                _handleTextInput('ל');
              }, 'ל'),
              contianerTile(14, () {
                _handleTextInput('מ');
              }, 'מ'),
              contianerTile(15, () {
                _handleTextInput('נ');
              }, 'נ'),
            ]),
            SizedBox(height: Adaptive.h(1.5)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              contianerTile(16, () {
                _handleTextInput('ס');
              }, 'ס'),
              contianerTile(17, () {
                _handleTextInput('ע');
              }, 'ע'),
              contianerTile(18, () {
                _handleTextInput('פ');
              }, 'פ'),
              contianerTile(19, () {
                _handleTextInput('צ');
              }, 'צ'),
              contianerTile(20, () {
                _handleTextInput('ק');
              }, 'ק'),
            ]),
            SizedBox(height: Adaptive.h(1.5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                contianerTile(21, () {
                  _handleTextInput('ר');
                }, 'ר'),
                contianerTile(22, () {
                  _handleTextInput('ש');
                }, 'ש'),
                contianerTile(23, () {
                  _handleTextInput('ת');
                }, 'ת'),
                contianerTile(24, () {
                  _handleTextInput('ם');
                }, 'ם'),
                contianerTile(25, () {
                  _handleTextInput('ך ');
                }, 'ך'),
              ],
            ),
            SizedBox(height: Adaptive.h(1.5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                contianerTile(26, () {
                  _handleTextInput('ץ');
                }, 'ץ'),
                contianerTile(27, () {
                  _handleTextInput('ף');
                }, 'ף'),
                contianerTile(28, () {
                  _addBookmark(_textEditingController.text);
                }, 'סמן\nעמוד'),
                contianerTile(29, () {
                  _handleTextInput('.');
                }, '.'),
                contianerTile(30, () {
                  _handleTextInput(',');
                }, ','),
              ],
            ),
            SizedBox(height: Adaptive.h(2)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              contianerTile(31, () {
                _handleTextInput('?');
              }, '?'),
              contianerTile(32, () {
                _handleTextInput(' ');
              }, 'רווח'),
            ]),
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
