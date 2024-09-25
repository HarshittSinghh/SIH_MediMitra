import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  final String id;

  const ReceiptScreen({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildReceiptItem('Unique ID:', id, isBold: true),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'This ID will be used for future reference.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.exit_to_app),
                label: Text('Exit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,  
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptItem(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label ${isBold ? value.toUpperCase() : value}',
        style: TextStyle(
          fontSize: 25, 
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isBold ? Colors.deepPurple : Colors.black, 
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
