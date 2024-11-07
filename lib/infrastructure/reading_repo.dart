import 'dart:convert';

import 'package:english_mastery/domain/reading/reading1_model.dart';
import 'package:english_mastery/env.dart';
import 'package:english_mastery/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Reading1Repo {
  Future<Reading1Model?> generate_reading1_repo() async {
    try {
      final response = await http.get(
        Uri.parse("${Env.host}${URLs.reading1}"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("reading generate status code : ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("reading generate body : ${response.body}");
        return Reading1Model.fromJson(responseData);
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
