import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class OpenAIPage extends StatefulWidget {
  @override
  _OpenAIPageState createState() => _OpenAIPageState();
}

class _OpenAIPageState extends State<OpenAIPage> {
  final TextEditingController _questionController = TextEditingController();
  String _answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask OpenAI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            ElevatedButton(
              onPressed: _getAnswer,
              child: Text('Ask'),
            ),
            if (_answer.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Answer: $_answer'),
              ),
          ],
        ),
      ),
    );
  }

  void _getAnswer() async {
    final question = _questionController.text;
    if (question.isNotEmpty) {
      final answer = await askOpenAI(question);
      setState(() {
        _answer = answer;
      });
    }
  }
}

Future<String> askOpenAI(String question) async {
  final response = await http.post(
    Uri.parse('http://your-backend-url/ask'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'question': question}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['answer'] as String;
  } else {
    throw Exception('Failed to load answer');
  }
}