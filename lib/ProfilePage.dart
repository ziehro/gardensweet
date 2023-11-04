import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  String _gardenSize = '';
  String _soilType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, size: 50),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  onSaved: (value) => _location = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Garden Size'),
                  onSaved: (value) => _gardenSize = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Soil Type'),
                  onSaved: (value) => _soilType = value ?? '',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      // Show a success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Saved')),
      );
    }
  }
}
