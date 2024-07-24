import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:flutter_application_1/pages/LoginPage.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/welcome_page.dart'; 
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive box
  await Hive.openBox("Workout_databse1");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        title: 'PUMP UP!',
        debugShowCheckedModeBanner: false,
        home: WelcomePage(), // Set LoginPage as the initial route
        routes: { // Define routes for navigation
          '/login': (context) => LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
