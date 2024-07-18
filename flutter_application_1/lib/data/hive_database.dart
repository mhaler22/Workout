

import 'package:flutter_application_1/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/exercise.dart';
import '../models/workout.dart';

class HiveDatabase{
  // reference our hive box
  final _myBox = Hive.box("workout_databse1");


  // check if there is already data stored, if not, record the start date
  bool previousDataExist(){
    if (_myBox.isEmpty) {
      print("previose data does not exist");
      _myBox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    }else{
      print("previouse data does exist");
      return true;
    }
  }



  // return start date as yyyymmdd
  String getStartDate() {
    return _myBox.get("START_DATE");
  }


  // write data
  void saveToDatabase(List<Workout> workouts) {
    // convert workout objects into lists of string so thath we can save in hive
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    if(exerciseCompleted(workouts)){
      _myBox.put("COMPLETION_STATUS${todaysDateYYYYMMDD()}",1);
    }else {
      _myBox.put("COMPLETION_STATUS${todaysDateYYYYMMDD()}",0);

    }
    
    _myBox.put("WOKROUTS", workoutList);
    _myBox.put("EXERCISE", exerciseList);
  }
  


  // read data, and reurn a list of workouts
  List<Workout> readFromDataBase() {
    List<Workout> mySaveWorkouts = [];
    
    List<String> workoutNames = _myBox.get("WOKROUTS");
    final ExerciseDetails = _myBox.get("EXERCISE");
    //create workout objects
    
    for (int i = 0; i <workoutNames.length; i++) {
      //each workout can have multiple exerxices
      List<Exercise> exerciseInEachWorkout = [];

      for (int j = 0; j < ExerciseDetails.length; j++) {
        // so add each exercise into a list
        exerciseInEachWorkout.add(Exercise(
          name: ExerciseDetails[i][j][0],
          weight: ExerciseDetails[i][j][1],
          reps: ExerciseDetails[i][j][2],
          sets: ExerciseDetails[i][j][3],
          isCompleted: ExerciseDetails[i][j][4] == "true" ? true : false,
        ),
        );
      }
      // create individual workout
      Workout workout = 
      Workout(name: workoutNames[i], exercises: exerciseInEachWorkout);

      // add individual wokrout to overall list
      mySaveWorkouts.add(workout);
    
    
    
    
    
    
    }

    return mySaveWorkouts;
    
  }




  // return completion status of a given date yyyymmdd
  int getCompletionStatus(String yyymmdd) {
    int completionStatus = _myBox.get("COMPLETION_STATUS$yyymmdd") ?? 0;
    return completionStatus;
  }


  // check if any exercise have been done 

  bool exerciseCompleted(List<Workout> workouts) {
    // go thru each workout
    for (var workout in workouts) {
      // go thur each exercise in workout
      for (var exercise in workout.exercises) {
        if(exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }
}


  // converts workout object into a list  -> eg.[upperbody, lowerbody]
  List<String> convertObjectToWorkoutList(List<Workout> workouts) {
    List<String> workoutList = [
      //e.g [upperbody]
    ];

    for (int i = 0; i <workouts.length; i++) {
      //in each workour, add this name. followed by lists of exercises
      workoutList.add(
        workouts[i].name,
      );
    }
    return workoutList;




  }
  
  //converts the exercise in a workout object into a list of strings
  List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
    List<List<List<String>>> exerciseList = [

    ];
    // go through each exercises
    for (int i = 0; i < workouts.length; i ++) { 
      // get exercises from each workout
      List<Exercise> exercisesInWorkout = workouts[i].exercises;

      List<List<String>> individualWorkout = [
        //upper body

      ];
      for (int j = 0; j < exercisesInWorkout.length; j++) {
        List<String> indiidualExercise= [

        ];
        indiidualExercise.addAll(
          [
          exercisesInWorkout[j].name,
          exercisesInWorkout[j].weight,
          exercisesInWorkout[j].reps,
          exercisesInWorkout[j].sets,
          exercisesInWorkout[j].isCompleted.toString(),
          ],
        );
        individualWorkout.add(indiidualExercise);
      }
      exerciseList.add(individualWorkout);
    }
    return exerciseList;





  }
