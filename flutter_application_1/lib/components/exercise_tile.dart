import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExerciseTile(
          exerciseName: "Exercise Name", // Replace with your exercise name
          weight: "50", // Replace with weight
          reps: "10", // Replace with reps
          sets: "3", // Replace with sets
          isCompleted: false, // Set to true if completed
          onCheckBoxChanged: (value) => print("Checkbox changed: $value"), // Handle checkbox change
        ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 157, 177, 186), // Set background color
        borderRadius: BorderRadius.circular(8.0), // Add rounded corners
      ),
      child: ListTile(
        title: Text(
          exerciseName,
          style: TextStyle(color: Colors.white), // Set exercise name text color to white
        ),
        subtitle: Row(
          children: [
            Chip(
              label: Text("$weight kg"),
              backgroundColor: Colors.blueGrey, // Set Chip background color
              labelStyle: TextStyle(color: Colors.white), // Optional: Set text color
            ),
            SizedBox(width: 8.0), // Optional: Add spacing between Chips
            Chip(
              label: Text("$reps reps"),
              backgroundColor: Colors.blueGrey, // Set Chip background color
              labelStyle: TextStyle(color: Colors.white), // Optional: Set text color
            ),
            SizedBox(width: 8.0), // Optional: Add spacing between Chips
            Chip(
              label: Text("$sets sets"),
              backgroundColor: Colors.blueGrey, // Set Chip background color
              labelStyle: TextStyle(color: Colors.white), // Optional: Set text color
            ),
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: onCheckBoxChanged,
        ),
      ),
    );
  }
}
