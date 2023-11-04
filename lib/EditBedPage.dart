import 'package:flutter/material.dart';
import 'models/GardenBed.dart';


class EditBedPage extends StatefulWidget {
  final GardenBed gardenBed;

  EditBedPage(this.gardenBed);

  @override
  _EditBedPageState createState() => _EditBedPageState();
}

class _EditBedPageState extends State<EditBedPage> {
  final TextEditingController _nameController = TextEditingController();
  final List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.gardenBed.name;
    _plants.addAll(widget.gardenBed.plants);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Garden Bed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Garden Bed Name'),
            ),
            // Optionally, add UI for editing plants in _plants list
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
      final updatedBed = GardenBed(widget.gardenBed.id, name, _plants);
      Navigator.pop(context, updatedBed);
    }
  }
}
