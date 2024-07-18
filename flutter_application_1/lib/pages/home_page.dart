
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/heat_map.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:provider/provider.dart';

import 'workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

// test controller
final newWorkoutNameController = TextEditingController();

// create a new workout
void createNewWorkout() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow content to scroll if needed
    builder: (context) => Container(
      padding: EdgeInsets.all(20.0), // Adjust padding as needed
      decoration: BoxDecoration(
        color: Colors.blueGrey[900], // Match background color
        borderRadius: BorderRadius.circular(10.0), // Add rounded corners
      ),
  child: Column(
        mainAxisSize: MainAxisSize.min, // Avoid unnecessary scrolling
        children: [
          Text(
            'Create New Workout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),

const SizedBox(height: 10.0), // Add spacing
          TextField(
            controller: newWorkoutNameController,
            decoration: InputDecoration(
              hintText: 'Workout Name',
              hintStyle: TextStyle(color: Colors.white70), // Adjust hint color
              fillColor: Colors.blueGrey[800], // Match background color slightly lighter
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none, // Remove border
              ),
            ),
            style: TextStyle(color: Colors.white), // Match text color
          ),
          const SizedBox(height: 10.0), // Add spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons
            children: [
              ElevatedButton(
                onPressed: save,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.amberAccent[700], // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: cancel,
                child: Text('Cancel'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey[800], // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// got to workout page
void goToWorkoutPage(String workoutName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage(
    workoutName: workoutName,
  ) ,));
}




// save workout
void save() {
  // get workout name from text controller
  String newWorkoutName = newWorkoutNameController.text;
  //add workout to workoutdata list
  Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

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
  newWorkoutNameController.clear();
}

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.amberAccent[700],
      appBar: AppBar(
        title:  const Text('PUMP UP!',
        style: TextStyle(fontFamily: 'Staatliches',
        ),
        ),
        backgroundColor: const Color.fromARGB(255, 213, 138, 0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewWorkout,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey[700],
      
        ),
      body: ListView(
        children: [

          MyHeatmap(datasets: value.heatMapDataSet, startDateYYYYMMDD: value.getStartDate()),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Stay consistent and crush your goals',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 17, 17),
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            ),


          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
        itemCount: value.getWorkoutList().length,
         itemBuilder:(context, index) => ListTile(
          title: Text(
            value.getWorkoutList()[index].name,
            style: TextStyle(
              color: const Color.fromARGB(255, 4, 4, 4),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              shadows:[ Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5.0,
                offset: const Offset(2.0, 2.0),
              ),
              ],
            ),
            ),
          trailing: IconButton(
            icon:const Icon(Icons.arrow_forward_ios,
            color: Colors.blueGrey,
            size: 30.0,),
            onPressed: () => 
              goToWorkoutPage(value.getWorkoutList()[index].name),
            ),
         ),
      ),
        ],
      )
      ),
    );
  }
}
class WorkoutCard extends StatelessWidget {
  final String workoutName;
  final VoidCallback onTap;

  const WorkoutCard({required this.workoutName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(workoutName),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}