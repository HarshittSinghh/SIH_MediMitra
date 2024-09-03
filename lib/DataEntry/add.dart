import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final TextEditingController _medicalHistoryController = TextEditingController();

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

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('patients').add({
        'name': _nameController.text,
        'age': _ageController.text,
        'gender': _genderController.text,
        'address': _addressController.text,
        'contact': _contactController.text,
        'medicalHistory': _medicalHistoryController.text,
        'createdAt': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient information saved successfully')),
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Information Form'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField(_nameController, 'Full Name', Icons.person),
              _buildTextField(_ageController, 'Age', Icons.calendar_today, keyboardType: TextInputType.number),
              _buildTextField(_genderController, 'Gender', Icons.wc),
              _buildTextField(_addressController, 'Address', Icons.location_on),
              _buildTextField(_contactController, 'Contact Number', Icons.phone, keyboardType: TextInputType.phone),
              _buildTextField(_medicalHistoryController, 'Medical History', Icons.medical_services, maxLines: 3),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(

                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
