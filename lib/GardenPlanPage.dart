import 'package:flutter/material.dart';
import 'GardenBed.dart';
import 'AddBedPage.dart';
import 'EditBedPage.dart';


class GardenPlanPage extends StatefulWidget {
  @override
  _GardenPlanPageState createState() => _GardenPlanPageState();
}

class _GardenPlanPageState extends State<GardenPlanPage> {
  final List<GardenBed> gardenBeds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garden Plan'),
      ),
      body: ListView.builder(
        itemCount: gardenBeds.length,
        itemBuilder: (context, index) {
          final bed = gardenBeds[index];
          return ListTile(
            title: Text(bed.name),
            subtitle: Text('${bed.plants.length} plants'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeBed(index),
            ),
            onTap: () => _editBed(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBed,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addBed() async {
    final newBed = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBedPage()),
    );
    if (newBed != null) {
      setState(() {
        gardenBeds.add(newBed);
      });
    }
  }

  void _editBed(int index) async {
    final updatedBed = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditBedPage(gardenBeds[index])),
    );
    if (updatedBed != null) {
      setState(() {
        gardenBeds[index] = updatedBed;
      });
    }
  }

  void _removeBed(int index) {
    setState(() {
      gardenBeds.removeAt(index);
    });
  }
}


