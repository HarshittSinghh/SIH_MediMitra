import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/Firebase/Login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImageUrl;
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  String? email;

  @override
  void initState() {
    super.initState();
    _fetchProfileImage();
    _fetchUserDetails();
    _createUserDocument();
  }

  @override
  void dispose() {
    phoneController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final profileImageUrl = user.photoURL;
        setState(() {
          _profileImageUrl = profileImageUrl;
          email = user.email;
        });
      }
    } catch (e) {
      print("Failed to fetch profile image: $e");
    }
  }

  Future<void> _fetchUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance.collection('Details').doc(user.uid).get();
        final data = userDoc.data();
        if (data != null) {
          setState(() {
            phoneController.text = data['mobile'] ?? '';
            genderController.text = data['gender'] ?? '';
            dobController.text = data['dob'] ?? '';
          });
        } else {
          print("No data found for user: ${user.uid}");
        }
      }
    } catch (e) {
      print("Failed to fetch user details: $e");
    }
  }

  Future<void> _createUserDocument() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('Details').doc(user.uid).get();
      if (!userDoc.exists) {
        await FirebaseFirestore.instance.collection('Details').doc(user.uid).set({
          'mobile': '',
          'gender': '',
          'dob': '',
          'email': user.email,
        });
      }
    }
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile',style:TextStyle(fontSize: 25,),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                ),
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                TextField(
                  controller: dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  try {
                    await FirebaseFirestore.instance.collection('Details').doc(user.uid).update({
                      'mobile': phoneController.text,
                      'gender': genderController.text,
                      'dob': dobController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile updated successfully')),
                    );
                    _fetchUserDetails();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update profile: $e')),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        appBar: AppBar(
          backgroundColor: Color(0xFF7CB8C0),
          foregroundColor: Colors.white,
          title: Text(
            "MediMitra",
            style:TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You are not logged in.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    final photoURL = _profileImageUrl ?? user.photoURL;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor:Color(0xFF7CB8C0),
        foregroundColor: Colors.white,
        title: Text(
          "MediMitra",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.list_outlined, color: Colors.white),
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutDialog();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color:Color(0xFF7CB8C0),
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(120),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Colors.black54,
                    child: Ink.image(
                      image: photoURL != null
                          ? NetworkImage(photoURL)
                          : AssetImage('assets/default_profile.png') as ImageProvider,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 20),
            // Centered User Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'Name: ${user.displayName ?? 'No Name'}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${user.email ?? 'No Email'}',
                    style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _editProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color(0xFF7CB8C0),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    child: Text('Edit Profile', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Additional Details Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, color:Color(0xFF7CB8C0)),
                        SizedBox(width: 10),
                        Text(
                          'Contact Number:',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      phoneController.text.isNotEmpty ? phoneController.text : 'Loading...',
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.person, color:Color(0xFF7CB8C0)),
                        SizedBox(width: 10),
                        Text(
                          'Gender:',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      genderController.text.isNotEmpty ? genderController.text : 'Loading...',
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.cake, color: Color(0xFF7CB8C0)),
                        SizedBox(width: 10),
                        Text(
                          'Date of Birth:',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      dobController.text.isNotEmpty ? dobController.text : 'Loading...',
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
