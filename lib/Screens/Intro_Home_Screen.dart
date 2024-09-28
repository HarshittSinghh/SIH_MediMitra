import 'package:flutter/material.dart';

class IntroHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.notification_important, color: Colors.red),
                      title: Text(
                        'Urgent Notice',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Important information you need to know.'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        
                      },
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), 
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _buildGridItem(Icons.policy, 'Policies'),
                        _buildGridItem(Icons.local_hospital, 'Hospitals'),
                        _buildGridItem(Icons.data_usage, 'Generalised Data'),
                        _buildGridItem(Icons.article, 'Related Articles'),
                      ],
                    ),
                  ),
                  // Few Banners
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildBanner('Banner 1: New Updates', Colors.lightBlue),
                        SizedBox(height: 10),
                        _buildBanner('Banner 2: Upcoming Features', Colors.green),
                        SizedBox(height: 10),
                        _buildBanner('Banner 3: Learn More', Colors.orange),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build grid items
  Widget _buildGridItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // Action on tapping grid item
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF7CB8C0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build banners
  Widget _buildBanner(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
