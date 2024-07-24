import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/exercise_tile.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final exerciseNameContorller = TextEditingController();
  final weightContorller = TextEditingController();
  final repsContorller = TextEditingController();
  final setsContorller = TextEditingController();

  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false).checkOffExercise(workoutName, exerciseName);
  }

  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add a new Exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Exercise Name'),
              controller: exerciseNameContorller,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Enter weight'),
              controller: weightContorller,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Enter reps'),
              controller: repsContorller,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Enter sets'),
              controller: setsContorller,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text("SAVE"),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text("CANCEL"),
          ),
        ],
      ),
    );
  }

  void save() {
    String newExerciseName = exerciseNameContorller.text;
    String weight = weightContorller.text;
    String reps = repsContorller.text;
    String sets = setsContorller.text;

    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExerciseName,
      weight,
      reps,
      sets,
    );

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameContorller.clear();
    weightContorller.clear();
    repsContorller.clear();
    setsContorller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName,
          style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blueGrey[800],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: Icon(Icons.add),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/workout.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
              child: Container(
                color: Colors.black.withOpacity(0.3), // Optional: adds a dark overlay to improve text readability
                child: ListView.builder(
                  itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
                  itemBuilder: (context, index) => ExerciseTile(
                    exerciseName: value.getRelevantWorkout(widget.workoutName).exercises[index].name,
                    weight: value.getRelevantWorkout(widget.workoutName).exercises[index].weight,
                    reps: value.getRelevantWorkout(widget.workoutName).exercises[index].reps,
                    sets: value.getRelevantWorkout(widget.workoutName).exercises[index].sets,
                    isCompleted: value.getRelevantWorkout(widget.workoutName).exercises[index].isCompleted,
                    onCheckBoxChanged: (val) => onCheckBoxChanged(
                      widget.workoutName,
                      value.getRelevantWorkout(widget.workoutName).exercises[index].name,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
