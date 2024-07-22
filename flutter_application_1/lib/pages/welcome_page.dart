import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/welcome.jpg'),
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
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  child: const Text(
                    'Start Workout Journey',
                    style: TextStyle(color: Colors.white),
                  ),
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
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: 2/1, // Adjust aspect ratio as needed
                        child: Image.asset('assets/photo2.jpeg', fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: 2/1, // Adjust aspect ratio as needed
                        child: Image.asset('assets/photo1.jpeg', fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: 2/1, // Adjust aspect ratio as needed
                        child: Image.asset('assets/photo3.jpeg', fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
