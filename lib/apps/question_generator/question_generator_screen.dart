import 'package:flutter/material.dart';
import 'package:app/backend/ChatGPT.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuestionCheckerPage(),
    );

  }
}

class QuestionCheckerPage extends StatefulWidget {
  @override
  _QuestionCheckerPageState createState() => _QuestionCheckerPageState();
}

class _QuestionCheckerPageState extends State<QuestionCheckerPage> {
  final _formKey = GlobalKey<FormState>();
  final _topicController = TextEditingController();
  final _answerController = TextEditingController();

  String _question = '';
  String _result = '';
  bool _isLoading = false;
  String _difficulty = 'Very Easy';

  final chatGPT = ChatGPT(); // Replace with your actual API key

  void _generateQuestion() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _question = '';
        _result = '';
      });

      try {
        final topic = _topicController.text;
        final question = await chatGPT.generateQuestion(topic, _difficulty);

        setState(() {
          _question = question;
        });
      } catch (e) {
        setState(() {
          _question = 'Error: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _checkAnswer() async {
    if (_question.isNotEmpty && _answerController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _result = '';
      });

      try {
        final userAnswer = _answerController.text;
        final result = await chatGPT.checkAnswer(_question, userAnswer);

        setState(() {
          _result = result;
        });
      } catch (e) {
        setState(() {
          _result = 'Error: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _topicController,
                decoration: InputDecoration(labelText: 'Topic'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a topic';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _difficulty,
                decoration: InputDecoration(labelText: 'Difficulty'),
                items: ['Very Easy', 'Easy', 'Medium', 'Hard', 'Very Hard']
                    .map((String difficulty) {
                  return DropdownMenuItem<String>(
                    value: difficulty,
                    child: Text(difficulty),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _difficulty = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _generateQuestion,
                child: _isLoading ? CircularProgressIndicator() : Text('Generate Question'),
              ),
              SizedBox(height: 20),
              Text(
                _question,
                style: TextStyle(fontSize: 16),
              ),
              if (_question.isNotEmpty)
                Column(
                  children: [
                    TextFormField(
                      controller: _answerController,
                      decoration: InputDecoration(labelText: 'Your Answer'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _checkAnswer,
                      child: _isLoading ? CircularProgressIndicator() : Text('Check Answer'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _result,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    _answerController.dispose();
    super.dispose();
  }
}
