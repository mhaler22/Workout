import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300], // Shade of red background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.red[300]!, Colors.red[200]!.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          child: ExerciseTile(
            exerciseName: "Exercise Name", // Replace with your exercise name
            weight: "50", // Replace with weight
            reps: "10", // Replace with reps
            sets: "3", // Replace with sets
            isCompleted: false, // Set to true if completed
            onCheckBoxChanged: (value) => print("Checkbox changed: $value"), // Handle checkbox change
          ),
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
        color: Colors.blueGrey, // Set background color to red (This won't affect final output)
        borderRadius: BorderRadius.circular(8.0), // Add rounded corners (This won't affect final output)
        boxShadow: [
          BoxShadow(
            color: Colors.yellow[200]!.withOpacity(0.3), // Yellow accent for shadow (This won't affect final output)
            blurRadius: 4.0, // Adjust blur radius for shadow softness (This won't affect final output)
            spreadRadius: 2.0, // Adjust spread radius for shadow size (This won't affect final output)
          ),
        ],
      ),
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(children: [
          //weight
          Chip(label: Text("$weight kg")),
          Chip(label: Text("$reps reps")),
          Chip(label: Text("$sets sets")),
        ]),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onCheckBoxChanged!(value),
        ),
      ),
    );
  }
}
