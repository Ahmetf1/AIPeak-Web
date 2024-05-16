import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatGPT {
  final String apiUrl;

  // Read the API key from a dotenv file
  final String apiKey = dotenv.env['OPENAI_API_KEY']!;

  ChatGPT({this.apiUrl = 'https://api.openai.com/v1/chat/completions'});

  Future<String> generateJobDescription(String jobTitle, String company, String location) async {
    final prompt = "Write a job description for the position of $jobTitle at $company located in $location.";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': prompt},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to generate job description: ${response.statusCode} ${response.body}');
    }
  }

  Future<String> generateQuestion(String topic, String difficulty) async {
    final prompt = "Create a $difficulty level question on the topic of $topic.";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': prompt},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to generate question: ${response.statusCode} ${response.body}');
    }
  }

  Future<String> checkAnswer(String question, String userAnswer) async {
    final prompt = "Question: $question\nUser's answer: $userAnswer\nIs the answer correct?";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': prompt},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to check answer: ${response.statusCode} ${response.body}');
    }
  }
}
