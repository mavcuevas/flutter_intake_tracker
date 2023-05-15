import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBvdU9wp-AV7k8bl52lqYLrKQ1ChsrHZpE",
          appId: "1:870288716893:web:0673436be9b7277d36c9b4",
          messagingSenderId: "870288716893",
          projectId: "water-intake-tracker-103a7"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Intake Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
      routes: {
        '/signin': (context) => const SignInPage(),
        '/AdminDashboard': (_) => new AdminDashboard(),
      },
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
                Navigator.pushNamed(context, '/signin');
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
                Navigator.pushNamed(
                    context, '/signup'); // Navigate to the signup page
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
                top: kToolbarHeight + 80.0, // Add some space below the app bar
                left: 50.0), // Add some space on the left side
            child: SingleChildScrollView(
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
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        //here set your transparent level
        color: const Color.fromARGB(255, 112, 202, 209),
        elevation: 0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
      ),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      Navigator.of(context)
                          .pushReplacementNamed("/AdminDashboard");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found' ||
                          e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid email or password'),
                          ),
                        );
                      }
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
