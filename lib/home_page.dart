import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/Login%20Page/login_sp.dart';
import 'package:health_app/Screens/Intro_Home_Screen.dart';
import 'package:health_app/Screens/chart.dart';
import 'package:health_app/Screens/Google_map.dart';
import 'package:health_app/Screens/chat_bot.dart';
import 'package:health_app/Screens/data_entry.dart';
import 'package:health_app/Firebase/Profile.dart';
import 'package:health_app/Notification.dart';
import 'package:health_app/drawer.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediMitra',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    IntroHomeScreen(),
    DataEntry(),
    BotScreen(),
    Chart(),
    MapScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'MediMitra',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.solidBell,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoNotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.database),
            label: 'Data Entry',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.robot),
            label: 'Ask Gemini',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartPie),
            label: 'Charts',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
