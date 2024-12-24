import 'dart:convert';
import 'dart:io';

import 'package:english_mastery/domain/speaking/speaking_check_audio_response_model.dart';
import 'package:english_mastery/domain/speaking/speaking_generate_model.dart';
import 'package:english_mastery/env.dart';
import 'package:english_mastery/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<Speaking2CheckAudioResponseModel?> uploadAudioWithHttp(
      String filePath, String generatedQuestion) async {
    try {
      print("uploadAudioWithHttp() called");

      // Check if the file exists
      final audioFile = File(filePath);
      if (!audioFile.existsSync()) {
        print('uploadAudioWithHttp() File not found at path: $filePath');
        return null;
      }

      // Compress the audio before uploading
      final compressedFilePath = filePath.replaceAll('.wav', '_compressed.wav');
      print("Compressing audio...");
      final compressedPath = await compressAudio(filePath, compressedFilePath);

      if (compressedPath == null) {
        print('uploadAudioWithHttp() Compression failed.');
        return null;
      }

      print("Audio compressed to: $compressedPath");

      // Prepare the request
      final uri = Uri.parse("${Env.host}${URLs.speaking2_check_audio}");
      final request = http.MultipartRequest('POST', uri)
        ..fields['question'] = generatedQuestion // Add the question field
        ..files.add(
          await http.MultipartFile.fromPath(
            'file', // This should match the key expected by the backend
            compressedPath,
            contentType: MediaType('audio', 'wav'), // Keep the MIME type as WAV
          ),
        );

      // Send the request
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        final responseData = jsonDecode(responseBody.body);

        print('uploadAudioWithHttp() Upload successful: $responseData');

        // Parse the JSON into Speaking2CheckAudioResponseModel
        return Speaking2CheckAudioResponseModel.fromJson(responseData);
      } else {
        final errorResponse = await http.Response.fromStream(response);
        print(
            'uploadAudioWithHttp() Upload failed with status: ${response.statusCode}');
        print('uploadAudioWithHttp() Error response: ${errorResponse.body}');
        return null;
      }
    } catch (e) {
      print('uploadAudioWithHttp() Error during audio upload: $e');
      return null;
    }
  }

  Future<String?> compressAudio(
      String inputFilePath, String outputFilePath) async {
    try {
      await FFmpegKit.execute(
          '-i $inputFilePath -ar 16000 -ac 1 -b:a 128k $outputFilePath');
      return outputFilePath;
    } catch (e) {
      print("Audio compression failed: $e");
      return null;
    }
  }

  Future<void> generateFeedbackAudio(String text) async {
    final url =
        Uri.parse('${Env.host}${URLs.speaking2_generate_feedback_audio}');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/generated_audio.mp3';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print('Audio saved at $filePath');
      } else {
        print('Failed to generate audio. Status Code: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
