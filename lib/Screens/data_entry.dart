import 'package:flutter/material.dart';
import 'package:health_app/DataEntry/add.dart';
import 'package:health_app/DataEntry/modify.dart';
import 'package:health_app/DataEntry/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DataEntry(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

class DataEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildCard(
              context,
              icon: Icons.add,
              title: 'Add',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AddEntry()),
                );
              },
            ),
            _buildCard(
              context,
              icon: Icons.edit,
              title: 'Modify',
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ModifyEntryPage()),
                );
              },
            ),
            _buildCard(
              context,
              icon: Icons.search,
              title: 'Search',
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SearchPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.deepPurple,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
