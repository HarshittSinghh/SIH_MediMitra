import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_app/DataEntry/add.dart';
import 'package:health_app/DataEntry/modify.dart';
import 'package:health_app/DataEntry/search.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:const MaterialColor(
          0xFF7CB8C0,
          <int, Color>{
            50: Color(0xFFE0F4F5),
            100: Color(0xFFB3E3E6),
            200: Color(0xFF80CFD6),
            300: Color(0xFF4DBBC6),
            400: Color(0xFF26AEBB),
            500: Color(0xFF009DAF),
            600: Color(0xFF008FA7),
            700: Color(0xFF007C9B),
            800: Color(0xFF006990),
            900: Color(0xFF004D7B),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DataEntry(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DataEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildListTile(
                context,
                icon: Icons.add,
                title: 'Add',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEntry()),
                  );
                },
                color: Color(0xFF7CB8C0),
              ),
              _buildListTile(
                context,
                icon: Icons.edit,
                title: 'Modify',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifyEntryPage()),
                  );
                },
                color: Color(0xFF7CB8C0),
              ),
              _buildListTile(
                context,
                icon: Icons.search,
                title: 'Search',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                color: Color(0xFF7CB8C0), 
              ),
              SizedBox(height: 20),
              const Text(
                'Recent Entries',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7CB8C0), 
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('DataEntry')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data!.docs;

                  if (data.isEmpty) {
                    return Center(child: Text('No data available'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final entry = data[index];
                      final name = entry['name'];
                      final uniqueID = entry['id'];
                      final timestamp = entry['createdAt'];

                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: $name',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF7CB8C0),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Unique ID: $uniqueID',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Date: ${DateFormat('yyyy-MM-dd').format(timestamp.toDate())}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Time: ${DateFormat('hh:mm a').format(timestamp.toDate())}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      required Color color}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8.0), 
      shadowColor: Colors.grey.withOpacity(0.5),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0), 
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.7),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28, 
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20, // Increase font size
            fontWeight: FontWeight.bold, // Make text bold
            color: color,
          ),
        ),
        tileColor: Color(0xFF7CB8C0).withOpacity(0.2), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
