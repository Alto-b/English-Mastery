import 'dart:convert';

import 'package:english_mastery/domain/speaking/speaking_generate_model.dart';
import 'package:english_mastery/env.dart';
import 'package:english_mastery/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SpeakingRepo {
  Future<SpeakingGenerateTaskModel?> speaking_generate_task() async {
    try {
      final response = await http.get(
        Uri.parse("${Env.host}${URLs.speaking2_generate_task}"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("speaking generate status code : ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("speaking generate body : ${response.body}");
        return SpeakingGenerateTaskModel.fromJson(responseData);
      } else {
        if (kDebugMode) {
          print('Failed to fetch speaking data: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return null;
    }
  }
}
