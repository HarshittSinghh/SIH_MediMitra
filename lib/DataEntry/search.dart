import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  void _searchEntries() async {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('DataEntry')
            .where('id', isEqualTo: query)
            .get();

        final addressSnapshot = await FirebaseFirestore.instance
            .collection('DataEntry')
            .where('address', isEqualTo: query)
            .get();

        final medicalHistorySnapshot = await FirebaseFirestore.instance
            .collection('DataEntry')
            .where('medicalHistory', isEqualTo: query)
            .get();

        final combinedDocs = [
          ...snapshot.docs,
          ...addressSnapshot.docs,
          ...medicalHistorySnapshot.docs
        ];

        setState(() {
          _searchResults = combinedDocs
              .map((doc) => {
                    'name': doc['name'],
                    'uniqueId': doc['id'],
                    'address': doc['address'],
                    'phone': doc['contact'],
                    'dateTime': (doc['createdAt'] as Timestamp).toDate(),
                    'medicalHistory': doc['medicalHistory'] ?? 'No medical history'
                  })
              .toList();
        });
      } catch (e) {
        print("Error fetching data: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Entries'),
        backgroundColor: const Color(0xff7CB8C0),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Unique ID, Address, or Medical History',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchEntries,
                ),
              ),
              onSubmitted: (_) => _searchEntries(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                      ? Center(child: Text('No results found'))
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final entry = _searchResults[index];
                            final dateTime = entry['dateTime'] as DateTime;

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ${entry['name'] ?? 'No name'}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff2C3E50)),
                                    ),
                                    Divider(color: Colors.grey),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Unique ID: ${entry['uniqueId'] ?? 'No ID'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.info, color: Colors.blueAccent),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Address: ${entry['address'] ?? 'No address'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.location_on, color: Colors.green),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Phone: ${entry['phone'] ?? 'No phone'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.phone, color: Colors.orange),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Date: ${dateTime.toLocal().toString().split(' ')[0]}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.calendar_today, color: Colors.purple),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Time: ${dateTime.toLocal().toString().split(' ')[1].split('.')[0]}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.access_time, color: Colors.red),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Medical History: ${entry['medicalHistory'] ?? 'No medical history'}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff7F8C8D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
