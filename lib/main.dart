import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Intake Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('💧 Water Intake Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0,
                top: 8.0), // Add some space on the right and top sides
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the login page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.black.withOpacity(0.05), // Make button transparent
                side: const BorderSide(width: 2.0, color: Colors.blue),
              ),
              child: const Text('Login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0,
                top: 8.0), // Add some space on the right and top sides
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the signup page
              },
              child: const Text('Sign Up'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            '16.png', // Replace with your own image
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: kToolbarHeight + 30.0, // Add some space below the app bar
                left: 50.0), // Add some space on the left side
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Your one stop shop to\nproper hydration!',
                  style: TextStyle(
                    fontSize: 54.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ), // Add some space between the Text widgets
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Water intake is essential to a healthy lifestyle. Keeping track of your water\nintake can be a challenging task. Fortunately, there are various tools\navailable to help you monitor and improve your water consumption.',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1, // Set line spacing to 1.0
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
                ElevatedButton(
                  child: const Text('Get Started'),
                  onPressed: () {
                    // Navigate to the Learn More page
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        //here set your transparent level
        color: const Color.fromARGB(255, 112, 202, 209),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('💧 Water Intake Tracker'),
            ),
            Text('WaterIntakeTracker @ 2023. All rights reserved.'),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Contact Us'),
            ),
          ],
        ),
      ),
    );
  }
}
