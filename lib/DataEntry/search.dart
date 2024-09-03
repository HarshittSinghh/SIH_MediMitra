import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  
  final List<Map<String, String>> _entries = [
    {'name': 'John Doe', 'details': 'Detail for John Doe'},
    {'name': 'Jane Smith', 'details': 'Detail for Jane Smith'},
    {'name': 'Alice Johnson', 'details': 'Detail for Alice Johnson'},
    {'name': 'Bob Brown', 'details': 'Detail for Bob Brown'},
    {'name': 'Harshit', 'details': 'Detail for Harshit'},
    {'name': 'Harshit Kumar Singh', 'details': 'Detail for Harshit'},
    {'name': 'Harshit Singh', 'details': 'Detail for Harshit'},
    {'name': 'Aryan', 'details': 'Details for Aryan'},
    {'name': 'Aryan Raj', 'details': 'Details for Aryan'},
    {'name': 'Aryan Raj Singh', 'details': 'Details for Aryan'},
  ];

  List<Map<String, String>> _searchResults = [];

  void _searchEntries() {
    final query = _searchController.text.toLowerCase();

    if (query.isNotEmpty) {
      setState(() {
        _searchResults = _entries.where((entry) {
          return entry['name']!.toLowerCase().contains(query);
        }).toList();
      });
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
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
              child: _searchResults.isEmpty
                  ? Center(child: Text('No results found'))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final entry = _searchResults[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(entry['name'] ?? 'No name'),
                            subtitle: Text(entry['details'] ?? 'No details'),
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
