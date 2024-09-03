import 'package:flutter/material.dart';
import 'package:health_app/Intro.dart';
import 'package:health_app/Notification.dart';
import 'package:health_app/Screens/SplashScreen.dart'; 

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    final String userName = 'User';
    final String userEmail = 'user@gmail.com'; 
    final String? userPhotoUrl; 

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.deepPurple),
              title: const Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoNotificationsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.policy, color: Colors.deepPurple),
              title: const Text(
                'Policies',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                // Add functionality for Policies section
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.deepPurple),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => IntroScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.deepPurple.shade100,
              height: 30,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: 10),
            ListTile(
              title: const Text(
                'Help & Support',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Add functionality for Help & Support
              },
            ),
          ],
        ),
      ),
    );
  }
}
