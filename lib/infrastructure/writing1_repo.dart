import 'dart:convert';
import 'package:english_mastery/domain/writing1_task_model.dart';
import 'package:english_mastery/env.dart';
import 'package:http/http.dart' as http;

class Writing1Repo {
  Future<Writing1GenerateTaskModel?> writing1_generate_task() async {
    try {
      final response = await http.get(
        Uri.parse("${Env.host}writing1/generate_task/"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Create and return the model from the response data
        return Writing1GenerateTaskModel.fromJson(responseData);
      } else {
        // Handle non-200 responses, if necessary
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error: $e');
      return null;
    }
  }
}
