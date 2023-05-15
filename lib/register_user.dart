import 'package:flutter/material.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  String? _name;
  int? _age;
  String? _gender;
  String? _fingerprintId;

  void _scanFingerprint() {
    // TODO: Implement code to scan fingerprint using ESP32 and AS608 fingerprint scanner
    setState(() {
      _fingerprintId =
          'Fingerprint ID'; // Set placeholder value for demo purposes
    });
  }

  void _submitForm() {
    // TODO: Implement code to submit user data to backend or database
    print('Name: $_name');
    print('Age: $_age');
    print('Gender: $_gender');
    print('Fingerprint ID: $_fingerprintId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => setState(() => _name = value),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => _age = int.tryParse(value)),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) => setState(() => _gender = value),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Fingerprint ID'),
                      enabled: false,
                      initialValue: _fingerprintId,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.fingerprint),
                    onPressed: _scanFingerprint,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
