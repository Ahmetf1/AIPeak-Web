import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPT {
  final String apiKey;
  final String apiUrl;

  ChatGPT({required this.apiKey, this.apiUrl = 'https://api.openai.com/v1/chat/completions'});

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
}
