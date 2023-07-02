// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typing/view/text_to_speech.dart';

class BookmarksScreen extends StatefulWidget {
  final List<String> bookmarks;
  final List<String> hwberewbookmarks;

  BookmarksScreen({required this.bookmarks, required this.hwberewbookmarks});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  int selectedLanguge = 1;
  Widget langaugeTile(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguge = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: Adaptive.h(8),
        width: Adaptive.w(30),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            color:
                selectedLanguge == index ? Colors.blue.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(10)),
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

  final TextToSpeech tts = TextToSpeech();
  SharedPreferences? _prefs;

  @override
  void initState() {
    initSharedPreferance();
    // TODO: implement initState
    super.initState();
  }

  initSharedPreferance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final _audioPlayer = AudioPlayer();
  bool isApiCall = false;
  Future<void> _getAudioFromAPI(String text) async {
    String apiEndpoint = 'https://api.narakeet.com/text-to-speech/mp3';
    String apiKey = 'PmVjOlrohp3x9dN17ZzEx70YCofYQQMuxoAp2QQ5';
    var params = {
      'voice': 'Ayelet',
    };
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        isApiCall = true;
      });

      try {
        final response = await http.post(
            Uri.parse(apiEndpoint + '?' + _encodeParams(params)),
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
      } catch (e) {
        setState(() {
          isApiCall = false;
        });
        Get.snackbar('Error', e.toString(), colorText: Colors.white);
      }
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play();
  }

  String _encodeParams(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Bookmarks'),
      ),
      body: Column(
        children: [
          SizedBox(height: Adaptive.h(2)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              langaugeTile('English', 1),
              SizedBox(
                width: Adaptive.w(5),
              ),
              langaugeTile('Hebrew', 2)
            ],
          ),
          SizedBox(height: Adaptive.h(2)),
          selectedLanguge == 1
              ? Expanded(
                  child: ListView.builder(
                    itemCount: widget.bookmarks.length,
                    itemBuilder: (context, index) {
                      return tile(index);
                    },
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: widget.hwberewbookmarks.length,
                    itemBuilder: (context, index) {
                      return hebrewTile(index);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  int selectedIndex = -1;
  Widget tile(int index) {
    return Container(
      padding: EdgeInsets.all(12),
      color: selectedIndex == index ? Colors.blue.shade900 : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.bookmarks[index],
            style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
                fontSize: Adaptive.px(30)),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  deletedialog(
                    context,
                    widget.bookmarks[index],
                    index,
                  );
                },
                child: Icon(
                  Icons.delete,
                  size: Adaptive.px(40),
                  color: selectedIndex == index
                      ? Colors.white
                      : Colors.blue.shade900,
                ),
              ),
              SizedBox(
                width: Adaptive.w(5),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  tts.speak(widget.bookmarks[index]);
                },
                child: Icon(
                  Icons.volume_up_outlined,
                  size: Adaptive.px(40),
                  color: selectedIndex == index
                      ? Colors.white
                      : Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int hebrewIndex = -1;
  Widget hebrewTile(int index) {
    return Container(
      padding: EdgeInsets.all(12),
      color: hebrewIndex == index ? Colors.blue.shade900 : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              isApiCall && hebrewIndex == index
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          hebrewIndex = index;
                        });
                        if (_prefs!.getString('api_key') == null) {
                          checkAPikey(context);
                        } else {
                          if (_prefs!.getString('api_key')!.isEmpty) {
                            checkAPikey(context);
                          } else {
                            _getAudioFromAPI(widget.hwberewbookmarks[index]);
                          }
                        }
                        //  tts.speak(widget.bookmarks[index]);
                      },
                      child: Icon(
                        Icons.volume_up_outlined,
                        size: Adaptive.px(40),
                        color: hebrewIndex == index
                            ? Colors.white
                            : Colors.blue.shade900,
                      ),
                    ),
              SizedBox(
                width: Adaptive.w(5),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    hebrewIndex = index;
                  });
                  deletedialog(context, widget.hwberewbookmarks[index], index);
                },
                child: Icon(
                  Icons.delete,
                  size: Adaptive.px(40),
                  color: hebrewIndex == index
                      ? Colors.white
                      : Colors.blue.shade900,
                ),
              )
            ],
          ),
          Text(
            widget.hwberewbookmarks[index],
            style: TextStyle(
                color:
                    hebrewIndex == index ? Colors.white : Colors.blue.shade900,
                fontSize: Adaptive.px(30)),
          ),
        ],
      ),
    );
  }

  void deletedialog(
    BuildContext context,
    String sentance,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Do you want to delete this sentance?"),
          // content: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [

          //   ],
          // ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (selectedLanguge == 1) {
                  setState(() {
                    widget.bookmarks
                        .removeWhere((element) => element == sentance);
                  });

                  await _prefs!.setStringList('bookmarks', widget.bookmarks);
                } else {
                  setState(() {
                    widget.hwberewbookmarks
                        .removeWhere((element) => element == sentance);
                  });

                  await _prefs!.setStringList(
                      'hebrew_bookmarks', widget.hwberewbookmarks);
                }

                Navigator.of(context).pop(false);
              },
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ],
        );
      },
    );
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
              TextButton(onPressed: () {}, child: Text('Generate API KEY '))
            ],
          ),
        );
      },
    );
  }
}
