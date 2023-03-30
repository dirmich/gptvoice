import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:gptvoice/home/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeController extends GetxController {
  late SpeechToText _speechToText;
  final openai = Get.find<OpenAIService>();
  late FlutterTts tts;
  var isKorean = true.obs;
  var isListening = false.obs;
  var isInitialized = false.obs;
  var readWords = ''.obs;
  @override
  void onInit() {
    _speechToText = SpeechToText();
    _initSpeech();
    tts = FlutterTts();
    _initTextToSpeech();
    super.onInit();
  }

  @override
  void onClose() {
    _speechToText.stop();
    tts.stop();
    super.onClose();
  }

  void toggleLanguage() {
    isKorean(!isKorean.value);
    tts.setLanguage(isKorean.value ? 'ko_KR' : 'en_US');
  }

  Future<void> speak(String speech) async {
    await tts.speak(speech);
  }

  Future<void> _initSpeech() async {
    await _speechToText.initialize(onStatus: _onStatus);
    isInitialized(true);
    var locales = await _speechToText.locales();
    debugPrint('Local:$locales');
    for (var e in locales) {
      debugPrint('Locale:${e.localeId} ${e.name}');
    }
  }

  Future<void> _initTextToSpeech() async {
    if (Platform.isIOS) {
      await tts.setSharedInstance(true);
    }
  }

  Future<void> startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: isKorean.value ? 'ko_KR' : 'en_US');
  }

  void _onStatus(String status) {
    debugPrint('status: $status');
    if (status == 'listening') {
      isListening(true);
    } else if (status == 'notListening') {
      isListening(false);
    } else if (status == 'done') {
      speak(readWords.value);
      openai.isArtPromptAPI(readWords.value);
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    readWords(result.recognizedWords);
    debugPrint('read: ${result.recognizedWords}');
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    isListening(false);
  }
}
