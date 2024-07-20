import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(image: AssetImage('assets/welcome.jpg'),
          fit: BoxFit.cover,
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
              const Text(
                'Welcome to PUMP UP!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Montserrat', // Or another bold font
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                    )
                ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: const Text('Start Workout Journey',
                style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[800],
                ),
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
