import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.red, Colors.yellowAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.fitness_center,
                size: 100.0,
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              Text(
                'Welcome to PUMP UP!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Montserrat', // Or another bold font
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[Colors.red, Colors.yellowAccent],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: const Text('Start Workout Journey'),
              ),
              const SizedBox(height: 20.0),
              const Text(
                '"Get stronger every day." - totoy jess soriano',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
