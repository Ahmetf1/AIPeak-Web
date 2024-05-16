import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPT {
  final String apiUrl;

  ChatGPT({this.apiUrl = 'http://157.230.124.148:7500'});

  Future<String> generateJobDescription(String jobTitle, String company, String location) async {
    final response = await http.post(
      Uri.parse('$apiUrl/generateJobDescription'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'jobTitle': jobTitle,
        'company': company,
        'location': location,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to generate job description: ${response.statusCode} ${response.body}');
    }
  }

  Future<String> generateQuestion(String topic, String difficulty) async {
    final response = await http.post(
      Uri.parse('$apiUrl/generateQuestion'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'topic': topic,
        'difficulty': difficulty,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to generate question: ${response.statusCode} ${response.body}');
    }
  }

  Future<String> checkAnswer(String question, String userAnswer) async {
    final response = await http.post(
      Uri.parse('$apiUrl/checkAnswer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'question': question,
        'userAnswer': userAnswer,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to check answer: ${response.statusCode} ${response.body}');
    }
  }
}