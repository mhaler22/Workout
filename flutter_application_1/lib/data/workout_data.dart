import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hive_database.dart';
import 'package:flutter_application_1/datetime/date_time.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/workout.dart';

class WorkoutData extends ChangeNotifier{

  final db = HiveDatabase();






List<Workout> workoutList = [
  // default workout
  Workout(
    name: "upperbody", 
    exercises:[
    Exercise(
      name: "Bicep Curls", 
      weight: "10",
       reps: "10", 
       sets: "3"),
       
       Exercise(
        name: "Incline dumbell press", 
        weight: "15",
         reps: "12",
          sets: "3"),

          Exercise(
            name: "shoulder press",
             weight: "10",
              reps: "10", 
              sets: "3"),

              Exercise(
                name: "lateral raise",
                 weight: "10",
                  reps: "12", 
                  sets: "3"),

                  Exercise(name: "tricep extension",
                   weight: "10",
                    reps: "12", 
                    sets: "3")
    ]
    )
];

void initializeWorkoutList() {
  if (db.previousDataExist()) {
    workoutList = db.readFromDataBase();
  } else {
    db.saveToDatabase(workoutList);
  }
  loadHeatMap();

}




// get the list of workout
List<Workout> getWorkoutList() {
  return workoutList;
}

// get lenght of a given workout
int numberOfExercisesInWorkout(String workoutName) {
  Workout relevantWorkout = getRelevantWorkout(workoutName);

  return relevantWorkout.exercises.length;
}


// add A workout
void addWorkout(String name){
  // add a new workout with a blank list of exercise
  workoutList.add(Workout(name: name, exercises: []));

  notifyListeners();
  db.saveToDatabase(workoutList);
}

// add an exercise to a workout
void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets){
  //find the relevant workout
  Workout relevantWorkout= getRelevantWorkout(workoutName);
  
   relevantWorkout.exercises.add(Exercise(
    name: exerciseName, 
    weight: weight, 
    reps: reps, 
    sets: sets
    ),
  );
  notifyListeners();
  db.saveToDatabase(workoutList);
}

// check off exercise
void checkOffExercise(String workoutName, String exerciseName){
  // find relevant workout and relevant excercise in that workout
  Exercise relevantExercise = getRelevantExcercise(workoutName, exerciseName);

  // check off boolean to show user completed the exercise
  relevantExercise.isCompleted = !relevantExercise.isCompleted;
  print('tapped');
  
  notifyListeners();
  db.saveToDatabase(workoutList);
  loadHeatMap();

}



// return relevant workout object, given a workout name
Workout getRelevantWorkout(String workoutName) { 
  Workout relevantWorkout =
   workoutList.firstWhere((workout) => workout.name == workoutName);

   return relevantWorkout;
}

// return relevant exercise pbject, given a workout name + exercise name
Exercise getRelevantExcercise(String workoutName, String exerciseName) {
  //find relevant wokrout first
  Workout relevantWorkout = getRelevantWorkout(workoutName);


  // then find the relevant exercise in that workout
  Exercise relevantExercise = 
  relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exerciseName);

  return relevantExercise;
}
String getStartDate() {
  return db.getStartDate();
}


Map<DateTime, int> heatMapDataSet = {};


void loadHeatMap() {
  DateTime startDate = createDateTimeObject(getStartDate());

  int daysInBetween = DateTime.now().difference(startDate).inDays;



  for (int i = 0; i < daysInBetween + 1; i++) {
    String yyyymmdd = 
    convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));


   // int completionStatus = db.getCompletionStatus(yyyymmdd);
   int completionStatus = db.getCompletionStatus(yyyymmdd);

    int year = startDate.add(Duration(days: i)).year;

    int month = startDate.add(Duration(days: i)).month;


    int day = startDate.add(Duration(days: i)).day;


final percentageForEachDay = <DateTime, int>{
  DateTime(year, month, day): completionStatus
};

heatMapDataSet.addEntries(percentageForEachDay.entries);


  }


}


}