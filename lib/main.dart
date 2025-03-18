import 'package:find_it/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/events_list_page.dart';
import 'screens/event_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Define your routes here
      routes: {
        '/eventsList': (context) => const EventsListPage(),
        '/eventDetails': (context) => const EventDetailsPage(),
        // Add other routes as needed
      },
      // Set your home page here
      home: const HomePage(), // Replace with your actual home page
    );
  }
}