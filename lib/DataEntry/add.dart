import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/DataEntry/ReceiptScreen.dart';
import 'dart:math';

class AddEntry extends StatefulWidget {
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _medicalHistoryController.dispose();
    super.dispose();
  }

  Future<String> _generateUniqueId() async {
    int uniqueId;
    do {
      uniqueId = Random().nextInt(90000);
    } while (await _isIdExists(uniqueId.toString()));
    return uniqueId.toString();
  }

  Future<bool> _isIdExists(String id) async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection('DataEntry').doc(id).get();
    return docSnapshot.exists;
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        String uniqueId = await _generateUniqueId();
        int age = int.parse(_ageController.text);

        await FirebaseFirestore.instance
            .collection('DataEntry')
            .doc(uniqueId)
            .set({
          'id': uniqueId,
          'name': _nameController.text,
          'age': age,
          'gender': _genderController.text,
          'address': _addressController.text,
          'contact': _contactController.text,
          'medicalHistory': _medicalHistoryController.text,
          'createdAt': Timestamp.now(),
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReceiptScreen(
              id: uniqueId,
            ),
          ),
        );

        // Clear the form
        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Information Form'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Added SingleChildScrollView
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Center(
                          child: Text(
                            "DataEntry Section",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        _buildTextField(
                            _nameController, 'Full Name', Icons.person),
                        _buildTextField(
                            _ageController, 'Age', Icons.calendar_today,
                            keyboardType: TextInputType.number),
                        _buildTextField(_genderController, 'Gender', Icons.wc),
                        _buildTextField(
                            _addressController, 'Address', Icons.location_on),
                        _buildTextField(
                            _contactController, 'Contact Number', Icons.phone,
                            keyboardType: TextInputType.phone),
                        _buildTextField(_medicalHistoryController,
                            'Medical History', Icons.medical_services,
                            maxLines: 3),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveData,
                          child: Text('Save & Print Receipt'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          if (labelText == 'Age' && int.tryParse(value) == null) {
            return 'Please enter a valid number for age';
          }
          if (labelText == 'Contact Number' && value.length != 10) {
            return 'Please enter a valid 10-digit contact number';
          }
          return null;
        },
      ),
    );
  }
}
