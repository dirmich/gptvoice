import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// const apiKey = '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';
const apiKey = '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';

class OpenAIService extends GetConnect {
  OpenAIService() {
    httpClient.timeout = const Duration(seconds: 10);
  }
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      debugPrint('[PROMPT]: $prompt');
      final res = await post(
          'https://api.openai.com/v1/chat/completions',
          jsonEncode({
            'model': 'gpt-3.5-turbo',
            'messages': [
              {
                'role': 'user',
                'content':
                    'Does this message want to generate an AI picture, image, art or anything similar? "$prompt". Simply answer with yes or no'
              }
            ]
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey'
          });

      debugPrint('AI] ${jsonEncode(res.body)}');
      // String recv = jsonDecode(res.body)['choices'][0]['message']['content'];
      if (res.statusCode != 200) throw 'Error';
      String recv = res.body['choices'][0]['message']['content'];
      recv = recv.trim();
      debugPrint('AI]=> $recv,${recv.toLowerCase() == 'yes.'}');
      // return recv.toLowerCase() == 'yes.';
      if (recv.toLowerCase() == 'yes.') {
        return await imageApi(prompt);
      } else {
        return await textApi(prompt);
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Error';
    }
  }

  Future<String> textApi(String prompt) async {
    try {
      final res = await post(
          'https://api.openai.com/v1/chat/completions',
          jsonEncode({
            'model': 'gpt-3.5-turbo',
            'messages': [
              {'role': 'user', 'content': prompt}
            ]
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey'
          });
      if (res.statusCode != 200) throw 'Error';
      String recv = res.body['choices'][0]['message']['content'];
      recv = recv.trim();
      debugPrint('RESP] $recv: ${res.bodyString}');
      return recv;
    } catch (e) {
      debugPrint(e.toString());
      return 'Error';
    }
  }

  Future<String> imageApi(String prompt) async {
    try {
      final res = await post(
          'https://api.openai.com/v1/images/generations',
          jsonEncode({
            'prompt': prompt,
            'n': 1,
            // 'size':'1024x1024'
          }),
          contentType: 'application/json',
          headers: {
            // 'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey'
          });
      debugPrint('RESP] ${(res.bodyString)} ${res.body}');
      if (res.statusCode != 200) throw 'Error';
      String recv = res.body['data'][0]['url'];
      recv = recv.trim();
      debugPrint('RESP] $recv: ${res.bodyString}');
      return recv;
    } catch (e) {
      debugPrint(e.toString());
      return 'Error';
    }
  }
}
