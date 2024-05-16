import 'package:flutter/material.dart';
import 'package:app/backend/ChatGPT.dart';

class JobDescriptionScreen extends StatelessWidget {
  const JobDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const JobDescriptionPage(),
    );
  }
}


class JobDescriptionPage extends StatefulWidget {
  const JobDescriptionPage({super.key});

  @override
  _JobDescriptionPageState createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final _jobTitleController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();

  String _jobDescription = '';
  bool _isLoading = false;

  final chatGPT = ChatGPT(apiKey: 'your_openai_api_key'); // Replace with your actual API key

  void _generateJobDescription() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _jobDescription = '';
      });

      try {
        final jobTitle = _jobTitleController.text;
        final company = _companyController.text;
        final location = _locationController.text;

        final description = await chatGPT.generateJobDescription(jobTitle, company, location);

        setState(() {
          _jobDescription = description;
        });
      } catch (e) {
        setState(() {
          _jobDescription = 'Error: $e';
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
        title: Text('Job Description Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _jobTitleController,
                decoration: InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(labelText: 'Company'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a company';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _generateJobDescription,
                child: _isLoading ? CircularProgressIndicator() : Text('Generate Description'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _jobDescription,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
