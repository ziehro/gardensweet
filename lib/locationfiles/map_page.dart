import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gardensweet/locationfiles/plant_recommendations.dart';
import 'package:gardensweet/locationfiles/usda_zone_mapping.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'dart:math';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';




class map_page extends StatelessWidget {
  final String location;

  map_page({required this.location});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USDA Zone Mapper',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}



Future<List<List<dynamic>>> loadCsvData() async {
  print('Before');
  final data = await rootBundle.loadString('assets/phm_us_zipcode.csv');
  print('After');
  return const CsvToListConverter().convert(data);
}

Future<Location> _getLocationCoordinates(String location) async {
  try {
    List<Location> locations = await locationFromAddress(location);
    return locations.first;
  } catch (e) {
    throw Exception('Error fetching location coordinates: $e');
  }
}

Future<Map<String, String>> loadZipCodeToZoneMapping() async {
  List<List<dynamic>> csvData = await loadCsvData();

  // Assuming the first column is the zip code and the second column is the USDA zone
  Map<String, String> zipToZone = {};
  print('just got loadcsvdata');
  for (var row in csvData) {
    zipToZone[row[0].toString()] = row[1].toString();
  }
  return zipToZone;
}




class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _usdaZone;
  LatLng? _center;
  bool _showTopography = false; // Add this flag
  double _zoom = 14.0; // default zoom level
  double _maxZoom = 18.0;  // default max zoom level for street map
  double? _propertySizeInAcres = 0.0;


  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeAsyncData();

    print('First few entries of _zipToZoneMapping: cats');
  }

  Future<void> _initializeAsyncData() async {
    try {
      // Loading the zip code to zone mapping asynchronously
      Map<String, String> mapping = await loadZipCodeToZoneMapping();
      // Now that we have the mapping, we can safely update the state
      setState(() {
        _zipToZoneMapping = mapping;
      });
      // For debugging purposes
      print('First few entries of _zipToZoneMapping: ${_zipToZoneMapping?.entries.take(10)}');
    } catch (e) {
      print('Failed to load zip code to zone mapping: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USDA Zone Mapper'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter your location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your property size in acres',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                double acres = double.tryParse(value) ?? 0;
                _propertySizeInAcres = acres;
                print(_propertySizeInAcres);

              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_zipToZoneMapping == null) {
                  print("Still loading zip to zone mapping, please wait");
                  return;
                }

                try {
                  Location location = await _getLocationCoordinates(
                      _locationController.text);
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      location.latitude!, location.longitude!);
                  String? zipCode = placemarks.first.postalCode;
                  String? zone = getUSDAZone(zipCode!);
                  print("Obtained Zip Code: $zipCode");

                  setState(() {
                    _center = LatLng(location.latitude!, location.longitude!);
                  });

                  print('Here: $zone');
                  if (zone != null) {
                    print('Looking up plants for zone: $zone');
                    setState(() {
                      _usdaZone = zone;
                      print('Looking up plants for zone: zone');
                      print('Looking up plants for zone: $_usdaZone');
                    });
                  } else {
                    print("Zip code not found or not in our database");
                  }
                } catch (e) {
                  print("Error fetching USDA zone: $e");
                }
              },
              child: Text('Find USDA Zone'),
            ),
            SizedBox(height: 20),
            if (_center != null)
              Expanded(
                child: buildMap(_center!, _zoom),
              ),
            SizedBox(height: 20),
            if (_usdaZone != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your USDA Zone is: $_usdaZone'),
                  SizedBox(height: 20),
                  Text('Recommended Plants:'),
                  ...getRandomPlants(plantRecommendations['Zone $_usdaZone'])
                      .map((plant) => Text(plant))
                      .toList() ?? [],
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_showTopography) {
            _maxZoom = 15.0;  // limit zoom for topo map
          } else {
            _maxZoom = 18.0;  // allow higher zoom for street map
          }

          if (_zoom > _maxZoom) {
            _zoom = _maxZoom;
          }


          setState(() {
            _showTopography = !_showTopography;
          });
        },
        tooltip: _showTopography ? 'Show Map' : 'Show Topography',

        child: Icon(_showTopography ? Icons.terrain : Icons.map),
      ),
    );
  }

  FlutterMap buildMap(LatLng center, double zoom) {
    return FlutterMap(
      options: MapOptions(
        center: center,
        zoom: zoom,
        maxZoom: _maxZoom,  // set the maximum zoom level


      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        if (_showTopography)
          TileLayer(
            urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),

        if (_propertySizeInAcres != null)
          PolygonLayer(
            polygons: [
              Polygon(
                points: _calculateSquare(center, _propertySizeInAcres!),
                color: Colors.red.withOpacity(0.2),
                borderColor: Colors.green,
                borderStrokeWidth: 2.0,
              ),
            ],
          ),
      ],
    );
  }

  List<LatLng> _calculateSquare(LatLng center, double acres) {
    // Convert acres to a distance metric (for example, square meters for a side)
    double distance = sqrt(acres * 4046.86);  // side in meters for the given acres

    // Calculate change in latitude
    double deltaLat = distance / 111000.0;

    // Calculate change in longitude
    double d = 111412.84 * cos(center.latitude) - 93.5 * cos(3 * center.latitude) + 0.118 * cos(5 * center.latitude);
    double deltaLon = distance / d;


    print('Center: $center');
    print('Acres: $acres');
    print('Distance (in meters): $distance');
    //print('Adjusted Latitudes: $adjustedLatUp, $adjustedLatDown');
    //print('Adjusted Longitudes: $adjustedLongRight, $adjustedLongLeft');


    List<LatLng> square = [
      LatLng(center.latitude + deltaLat / 2, center.longitude + deltaLon / 2).clampLatLng(),
      LatLng(center.latitude + deltaLat / 2, center.longitude - deltaLon / 2).clampLatLng(),
      LatLng(center.latitude - deltaLat / 2, center.longitude - deltaLon / 2).clampLatLng(),
      LatLng(center.latitude - deltaLat / 2, center.longitude + deltaLon / 2).clampLatLng(),
    ];
    square.add(square.first);  // Close the polygon
    return square;
  }
}

// Extension method to clamp latitude and longitude
extension on LatLng {
  LatLng clampLatLng() {
    return LatLng(
        this.latitude.clamp(-90.0, 90.0),
        this.longitude.clamp(-180.0, 180.0)
    );
  }
}



Map<String, String>? _zipToZoneMapping;

String? getUSDAZone(String zipCode) {
  if (_zipToZoneMapping == null) {
    print("Zip to zone mapping not yet available");
    return null;
  }
  return _zipToZoneMapping![zipCode];
}


List<String> getRandomPlants(List<String>? plants) {
  if (plants == null || plants.isEmpty) {
    return [];
  }
  List<String> modifiablePlants = List.from(plants);
  if (modifiablePlants.length <= 10) {
    return modifiablePlants;
  }
  modifiablePlants.shuffle(Random());
  return modifiablePlants.sublist(0, 10);
}





