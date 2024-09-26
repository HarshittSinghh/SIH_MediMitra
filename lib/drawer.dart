import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/Firebase/Login.dart' as firebase_login;
import 'package:health_app/Login%20Page/login_dep.dart';
import 'package:health_app/Login%20Page/login_sp.dart';
import 'package:health_app/Notification.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? Icon(Icons.person, size: 30, color: Colors.deepPurple)
                        : null,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? 'User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          user?.email ?? 'Email unavailable',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
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
              onTap: () async {
                // Clear session and sign out
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
               MaterialPageRoute(builder: (context) => firebase_login.LoginPage()),
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
              leading: Icon(Icons.account_balance,
                  color: Colors.deepPurple),
              title: const Text(
                'Department Login',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginDept(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings,
                  color: Colors.deepPurple), 
              title: const Text(
                'Admin Login',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginSV(),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.deepPurple.shade100,
              height: 30,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text(
                'Help & Support',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Add Help & Support functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
