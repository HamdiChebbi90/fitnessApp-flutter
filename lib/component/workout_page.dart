import 'dart:math';

import 'package:fitnessapp/component/exercice.dart';
import 'package:fitnessapp/component/exercice_page.dart';
import 'package:fitnessapp/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.workoutName}) : super(key: key);
  final String workoutName;

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onchekboxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkExercise(workoutName, exerciseName);
  }

  //text controller
  final newExerciceController = TextEditingController();
  final newWeightController = TextEditingController();
  final newSetsController = TextEditingController();
  final newRepsController = TextEditingController();

  //create new exercise
  void CreateNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Create New Exercise"),
          content: Column(
            children: [
              TextField(
                controller: newExerciceController,
                decoration: const InputDecoration(
                  labelText: "Exercise Name",
                ),
              ),
              TextField(
                controller: newWeightController,
                decoration: const InputDecoration(
                  labelText: "Weight",
                ),
              ),
              TextField(
                controller: newSetsController,
                decoration: const InputDecoration(
                  labelText: "Sets",
                ),
              ),
              TextField(
                controller: newRepsController,
                decoration: const InputDecoration(
                  labelText: "Reps",
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(onPressed: save, child: const Text("Save")),
            MaterialButton(onPressed: canel, child: const Text("Cancel")),
          ]),
    );
  }

  //save exercise

  void save() {
    //get exercice name from text field
    String exerciceName = newExerciceController.text;
    //get weight from text field
    String weight = newWeightController.text;
    //get sets from text field
    String sets = newSetsController.text;
    //get reps from text field
    String reps = newRepsController.text;

    //add exercise
    Provider.of<WorkoutData>(context, listen: false).addExercise(
        widget.workoutName,
        exerciceName,
        sets.toString(),
        reps.toString(),
        weight.toString());

    //close dialog
    Navigator.pop(context);
    clear();
  }

  //cancel Exercise
  void canel() {
    Navigator.pop(context);
    clear();
  }

  //clear controllers
  void clear() {
    newExerciceController.clear();
    newWeightController.clear();
    newSetsController.clear();
    newRepsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              title: Text(widget.workoutName),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: CreateNewExercise,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: value.numberOfExercises(widget.workoutName),
              itemBuilder: (context, index) => ExercisePage(
                exerciseName: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name,
                weight: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .weight,
                sets: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .sets,
                reps: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .reps,
                isDone: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .isDone,
                onchekboxChanged: (val) => onchekboxChanged(
                  widget.workoutName,
                  value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .name,
                ),
              ),
            ));
      },
    );
  }
}
