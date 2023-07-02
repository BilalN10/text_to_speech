import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';
class Check{
final _audioPlayer = AudioPlayer();
Future<void> getVoice(String text) async {
  String apiEndpoint = 'https://api.narakeet.com/text-to-speech/mp3';
  String apiKey = 'your api key';
  var params = {
    'voice': 'Ayelet',
  };
try {
    final response = await http.post(
      Uri.parse('$apiEndpoint?${_encodeParams(params)}'),
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'text/plain',
        'accept': 'application/octet-stream',
      },
      body: text,
    );

    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/audio.mp3';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      await _audioPlayer.setFilePath(filePath);

      await _playAudio();
    }
  } catch (e) {
    log('Error: ${e.toString()}');
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
}