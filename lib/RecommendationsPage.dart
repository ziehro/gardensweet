import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RecommendationsPage extends StatefulWidget {
  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  String _location = '';
  Map<String, dynamic> _recommendations = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo-Specific Recommendations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _getRecommendations,
              child: Text('Get Recommendations'),
            ),
            if (_recommendations.isNotEmpty)
              Text('Recommended Plants: ${_recommendations['plants']}'),
            // ... Display other recommendations
          ],
        ),
      ),
    );
  }

  void _getRecommendations() async {
    if (_location.isNotEmpty) {
      final recommendations = await getRecommendations(_location);
      setState(() {
        _recommendations = recommendations;
      });
    }
  }
}


Future<Map<String, dynamic>> getRecommendations(String location) async {
  final response = await http.post(
    Uri.parse('http://your-backend-url/recommendations'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'location': location}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to load recommendations');
  }
}