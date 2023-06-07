import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_intake_tracker/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserData {
  final String id;
  final String name;
  final int age;
  final String dateCreated;

  UserData({
    required this.id,
    required this.name,
    required this.age,
    required this.dateCreated,
  });
}

class RegisterScreen extends StatefulWidget {
  static const String id = "register-screen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late CollectionReference users;
  List<UserData> userDataList = [];

  @override
  void initState() {
    super.initState();
    users = FirebaseFirestore.instance.collection('users');
    fetchUserData();
  }

  Future<void> updateUserData(UserData userData, String name, int age) async {
    DocumentReference docRef = users.doc(userData.id);
    await docRef.update({
      'name': name,
      'age': age,
    });
  }

  Future<void> fetchUserData() async {
    QuerySnapshot snapshot = await users.get();
    List<UserData> dataList = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print('ID: ${doc.id}');
      print('Name: ${data['name']}');
      print('Age: ${data['age']}');
      print('Date Created: ${data['dateCreated']}');

      UserData userData = UserData(
        id: doc.id,
        name: data['name'] ?? 'Unknown',
        age: data['age'] ?? 0,
        dateCreated: data['dateCreated'],
      );
      dataList.add(userData);
    });

    setState(() {
      userDataList = dataList;
    });
  }

  Future<void> registerUser() async {
    // Make a request to the API endpoint
    http.Response response = await http.get(
      Uri.parse(
          'https://us-central1-water-intake-tracker-103a7.cloudfunctions.net/app/register'),
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Request was successful, refresh the data table
      await fetchUserData();
    } else {
      // Request failed, display an error message
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> saveChanges(UserData userData, String name, int age) async {
    await updateUserData(userData, name, age);
    await fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Date Created')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: userDataList.map((userData) {
                    TextEditingController nameController =
                        TextEditingController(text: userData.name);
                    TextEditingController ageController =
                        TextEditingController(text: userData.age.toString());

                    return DataRow(
                      cells: [
                        DataCell(Text(userData.id)),
                        DataCell(TextField(controller: nameController)),
                        DataCell(TextField(controller: ageController)),
                        DataCell(Text(userData.dateCreated)),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              String newName = nameController.text;
                              int newAge =
                                  int.tryParse(ageController.text) ?? 0;
                              saveChanges(userData, newName, newAge);
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fetchUserData(); // Refresh the data
                  },
                  child: const Text('Refresh'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    registerUser();
                  },
                  child: const Text('Send Message'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
