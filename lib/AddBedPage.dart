import 'package:flutter/material.dart';
import 'models/GardenBed.dart';


class AddBedPage extends StatefulWidget {
  @override
  _AddBedPageState createState() => _AddBedPageState();
}

class _AddBedPageState extends State<AddBedPage> {
  final TextEditingController _nameController = TextEditingController();
  final List<Plant> _plants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Garden Bed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Garden Bed Name'),
            ),
            // Optionally, add UI for adding plants to _plants list
            ElevatedButton(
              onPressed: _save,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      final newBed = GardenBed('some-id', name, _plants);
      Navigator.pop(context, newBed);
    }
  }
}
