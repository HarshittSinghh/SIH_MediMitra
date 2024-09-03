import 'package:flutter/material.dart';

class IntroHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( 
                  child:Text('Welcome to our app'),
                  ),
                ],
             ),
            ),
          ),
        ],
      ),
    );
  }
}