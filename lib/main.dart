import 'package:flutter/material.dart';
import 'package:flutter_intake_tracker/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBvdU9wp-AV7k8bl52lqYLrKQ1ChsrHZpE",
          appId: "1:870288716893:web:0673436be9b7277d36c9b4",
          messagingSenderId: "870288716893",
          projectId: "water-intake-tracker-103a7"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intake Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.landingPage,
    );
  }
}
