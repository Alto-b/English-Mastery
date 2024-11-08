import 'dart:convert';

import 'package:english_mastery/domain/grammar/past_time_model.dart';
import 'package:english_mastery/env.dart';
import 'package:english_mastery/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GrammarRepo {
  Future<PastTimeModel?> generate_past_time() async {
    try {
      print("qweqwe 1");
      final response = await http.get(
        Uri.parse("${Env.host}${URLs.past_time}"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("qweqwe 2");
      print(
          "grammar generate_past_time() status code : ${response.statusCode}");
      print("qweqwe 3");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("grammar generate body : ${response.body}");
        return PastTimeModel.fromJson(responseData);
      } else {
        if (kDebugMode) {
          print('Failed to fetch grammar data: ${response.statusCode}');
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
