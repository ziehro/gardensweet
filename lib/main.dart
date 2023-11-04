import 'package:flutter/material.dart';
import 'package:gardensweet/CommunityPage.dart';
import 'package:gardensweet/GardenPlanPage.dart';
import 'package:gardensweet/MarketplacePage.dart';
import 'package:gardensweet/OpenAIPage.dart';
import 'package:gardensweet/LocationsPage.dart';
import 'models/Product.dart';
import 'ProfilePage.dart';

void main() {
  runApp(MyGardenApp());
}

class MyGardenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PermaGarden',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PermaGarden'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),

            ListTile(
              title: Text('Ask Jimmy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpenAIPage()),
                );
              },
            ),
              ListTile(
                title: Text('Location Recommendations'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendationsPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Garden Plan'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GardenPlanPage()),
                  );
                },
              ),
                ListTile(
                  title: Text('Community'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommunityPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Monitoring'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommunityPage()),
                    );
                  },
                ),
                  ListTile(
                    title: Text('Education'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CommunityPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Marketplace'),
                    onTap: () {

                      List<Product> products = [
                        Product('1', 'Product 1', 'Description 1', 10.0, 'https://example.com/image1.jpg'),
                        // ... other products ...
                      ];

                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MarketplacePage(products)),
                      );
                    },
            ),
            ListTile(
              title: Text('Reporting'),
              onTap: () {
                // Update the state of the app
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Game'),
              onTap: () {
                // Update the state of the app
                Navigator.pop(context);
              },
            ),
            // ... Add more items
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to PermaGarden',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
