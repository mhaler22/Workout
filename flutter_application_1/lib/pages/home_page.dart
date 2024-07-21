import 'dart:ui'; // Required for the BackdropFilter
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

  final newWorkoutNameController = TextEditingController();

  void createNewWorkout() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Create New Workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: newWorkoutNameController,
              decoration: InputDecoration(
                hintText: 'Workout Name',
                hintStyle: const TextStyle(color: Colors.white70),
                fillColor: Colors.blueGrey[800],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: save,
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amberAccent[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey[800],
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

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          title: const Text(
            'PUMP UP!',
            style: TextStyle(
              fontFamily: 'Staatliches',
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blueGrey[800],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueGrey[700],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/homepage.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3), // Optional: Adds a dark overlay to improve text readability
                child: ListView(
                  children: [
                    MyHeatmap(
                      datasets: value.heatMapDataSet,
                      startDateYYYYMMDD: value.getStartDate(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: 16.0,
                      ),
                      child: Text(
                        'Stay consistent and crush your goals',
                        style: TextStyle(
                          color: Color.fromARGB(255, 243, 240, 240),
                          fontSize: 30.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.getWorkoutList().length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          value.getWorkoutList()[index].name,
                          style: TextStyle(
                            color: Color.fromARGB(255, 243, 242, 242),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5.0,
                                offset: const Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueGrey,
                            size: 30.0,
                          ),
                          onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}