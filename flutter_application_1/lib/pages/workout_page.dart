import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/exercise_tile.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key,  required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

    //checlbox was tapped
    void onCheckBoxChanged(String workoutName, String exerciseName) {
      Provider.of<WorkoutData>(context, listen: false).checkOffExercise(workoutName, exerciseName);
    }

    // text controllers
    final exerciseNameContorller = TextEditingController();
    final weightContorller = TextEditingController();
    final repsContorller = TextEditingController();
    final setsContorller = TextEditingController();







  // create new Exercise
  void createNewExercise() {
    showDialog(context: context,
     builder: (context) => AlertDialog(
      title: Text('Add a new Exercise'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
      //exercise name
      TextField(
        decoration: const InputDecoration(
          hintText: 'exercise Name'),
        
        controller: exerciseNameContorller,
      ),


      //weight
      TextField(
        decoration: const InputDecoration(
          hintText: 'enter weight'
        ),
        controller: weightContorller,
      ),


      //reps
      TextField(
        decoration: const InputDecoration(
          hintText: 'enter reps'
        ),
        controller: repsContorller,
      ),


      //sets
      TextField(
        decoration: const InputDecoration(
          hintText: 'enter sets'
        ),
        controller: setsContorller,
      ),

      ],
      ),
      actions: [
      //save button
  MaterialButton(
    onPressed: save,
    child: Text("SAVE"),
    ),

// cancel button
MaterialButton(
    onPressed: cancel,
    child: Text("CANCEL"),
    ),

      ],
     ),
     );
  }

  // save workout
void save() {
  // get exercise name from text controller
  String newEexerciseName = exerciseNameContorller.text;
  String weight = weightContorller.text;
  String reps = repsContorller.text;
  String sets = setsContorller.text;
  //add workout to workoutdata list
  Provider.of<WorkoutData>(context, listen: false).addExercise(
    widget.workoutName,
     newEexerciseName,
      weight,
       reps, 
       sets,
       );

//pop dialog box
Navigator.pop(context);
clear();

}


// cancel
void cancel() {
//pop dialog box
Navigator.pop(context);
clear();
}


// clear controller
void clear() {
  exerciseNameContorller.clear();
  weightContorller.clear();
  repsContorller.clear();
 setsContorller.clear();
}

  @override
  Widget build(BuildContext content) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
      appBar: AppBar(title: Text(widget.workoutName)),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewExercise,
        child: Icon(Icons.add),),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.yellowAccent, Colors.red],
            begin:  Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),



      child: ListView.builder(
        itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
        itemBuilder: (context, index) =>ExerciseTile(
          exerciseName: value.getRelevantWorkout(widget.workoutName).exercises[index].name,
           weight: value.getRelevantWorkout(widget.workoutName).exercises[index].weight,
           reps: value.getRelevantWorkout(widget.workoutName).exercises[index].reps,
           sets: value.getRelevantWorkout(widget.workoutName).exercises[index].sets,
           isCompleted: value.getRelevantWorkout(widget.workoutName).exercises[index].isCompleted,
           onCheckBoxChanged: (val) => onCheckBoxChanged(
            widget.workoutName,
            value
            .getRelevantWorkout(widget.workoutName)
            .exercises[index]
            .name,
           ),
           ),
        ),
      ),
      ),
    );
  }
}