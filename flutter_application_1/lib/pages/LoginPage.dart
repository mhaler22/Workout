import 'dart:math';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // For form validation

  String? _usernameError;
  String? _passwordError;
  bool _isLoading = false; // Flag to track loading state

  bool _authenticate() {
    bool result = false;
      if  (_usernameController.text == 'rhejie' &&
        _passwordController.text == 'rhejie') result = true;
      if  (_usernameController.text == 'jans' &&
        _passwordController.text == 'jans') result =true;
      if  (_usernameController.text == 'erwin' &&
        _passwordController.text == 'erwin')result = true;
      if  (_usernameController.text == 'jaz' &&
        _passwordController.text == 'jaz') result =true;

    return result;
  }

  // Gym quote list
  final List<String> gymQuotes = [
    "The only person you are destined to become is the person you decide to be. - Ralph Waldo Emerson (general motivational)",
    "Every workout is a step closer to your goals. - Unknown",
    "Sore today, strong tomorrow. - Unknown",
    "It's not about being better than someone else. It's about being better than the person you were yesterday. - Unknown",
    "The difference between ordinary and extraordinary is that little extra. - Jimmy Johnson",
    "If it doesn't challenge you, it doesn't change you. - Unknown",
    "Train insane or remain the same. - Unknown (more intense)",
    "You don't have to be great to start, but you have to start to be great. - Zig Ziglar",
    "Progress, not perfection. - Unknown",
    "Excuses are just muscles that make you weaker. - Unknown (humorous)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: Colors.blueGrey[800]!, // Set app bar color to blue-grey
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.yellowAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  errorText: _usernameError,
                  hintStyle: TextStyle(color: Colors.blueGrey[800]),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[800]!),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null; // Assuming no other username validation needed
                },
                style: TextStyle(color: Colors.blueGrey[800]!), // Set text color to blue-grey
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  errorText: _passwordError,
                  hintStyle: TextStyle(color: Colors.blueGrey[800]),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[800]!),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null; // Assuming no other password validation needed
                },
                style: TextStyle(color: Colors.blueGrey[800]!), // Set text color to blue-grey
              ),
              const SizedBox(height: 20.0),
              Text(
                gymQuotes[Random().nextInt(gymQuotes.length)], // Access random quote
                style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20.0),

            
                             _isLoading
                  ? CircularProgressIndicator() // Show progress indicator when loading
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          // Simulate authentication delay (replace with actual authentication logic)
                          await Future.delayed(Duration(seconds: 2));

                          if (_authenticate()) {
                            // Navigate to the next screen on successful login
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            setState(() {
                              _isLoading = false;
                              _usernameError = 'Invalid username or password';
                              _passwordError = 'Invalid username or password';
                            });
                          }
                        }
                      },
                      child: Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
