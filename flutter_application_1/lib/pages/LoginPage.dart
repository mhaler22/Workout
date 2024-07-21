import 'dart:ui'; // For ImageFilter

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
    // Simplified authentication logic for demonstration
    if (_usernameController.text == 'rhejie' && _passwordController.text == 'rhejie') return true;
    if (_usernameController.text == 'jans' && _passwordController.text == 'jans') return true;
    if (_usernameController.text == 'erwin' && _passwordController.text == 'erwin') return true;
    if (_usernameController.text == 'jaz' && _passwordController.text == 'jaz') return true;
    return false;
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
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: Colors.blueGrey[800]!, // Set app bar color to blue-grey
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 500.0, // Set width of the container
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Round the edges of the container
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Apply blur effect
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4), // Semi-transparent background for readability
                    borderRadius: BorderRadius.circular(15.0), // Match the border radius
                    border: Border.all(color: Colors.blueGrey[800]!, width: 4.0), // Add border
                  ),
                  child: Card(
                    color: Colors.transparent, // Make the Card background transparent
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Round the edges of the Card
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Use min to shrink-wrap the Card
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: 'Enter username',
                                errorText: _usernameError,
                                hintStyle: TextStyle(color: Color.fromARGB(255, 237, 239, 240)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey[800]!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username cannot be empty';
                                }
                                return null; // Assuming no other username validation needed
                              },
                              style: TextStyle(color: const Color.fromARGB(255, 243, 244, 245)!), // Set text color to blue-grey
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter password',
                                errorText: _passwordError,
                                hintStyle: TextStyle(color: Color.fromARGB(255, 248, 250, 251)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: const Color.fromARGB(255, 254, 254, 254)!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null; // Assuming no other password validation needed
                              },
                              style: TextStyle(color: const Color.fromARGB(255, 228, 231, 232)!), // Set text color to blue-grey
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              gymQuotes[Random().nextInt(gymQuotes.length)], // Access random quote
                              style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, color: Colors.white),
                            ),
                            const SizedBox(height: 30.0),
                            _isLoading
                                ? const CircularProgressIndicator() // Show progress indicator when loading
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        // Simulate authentication delay (replace with actual authentication logic)
                                        await Future.delayed(const Duration(seconds: 2));

                                        if (_authenticate()) {
                                          // Navigate to the next screen on successful login
                                          Navigator.pushReplacementNamed(context, '/welcome');
                                        } else {
                                          setState(() {
                                            _isLoading = false;
                                            _usernameError = 'Invalid username or password';
                                            _passwordError = 'Invalid username or password';
                                          });
                                        }
                                      }
                                    },
                                    child: const Text('Login', style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey[800]!,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
