import 'package:fitnessapp/component/exercice.dart';
import 'package:fitnessapp/component/workout.dart';
import 'package:fitnessapp/data/hive_db.dart';
import 'package:flutter/material.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDB();

  List<Workout> workoutList = [
    Workout(
      name: 'Chest',
      exercises: [
        Exercise(name: 'Bench Press', sets: "3", reps: "10", weight: "50"),
        Exercise(
            name: 'Incline Bench Press', sets: "3", reps: "10", weight: "50"),
        Exercise(
            name: 'Decline Bench Press', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Dumbbell Fly', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Cable Fly', sets: "3", reps: "10", weight: "50"),
      ],
    ),
    Workout(
      name: 'Back',
      exercises: [
        Exercise(name: 'Deadlift', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Pull Up', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Lat Pulldown', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Seated Row', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Bent Over Row', sets: "3", reps: "10", weight: "50"),
      ],
    ),
    Workout(
      name: 'Legs',
      exercises: [
        Exercise(name: 'Squat', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Leg Press', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Leg Extension', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Leg Curl', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Calf Raise', sets: "3", reps: "10", weight: "50"),
      ],
    ),
    Workout(
      name: 'Shoulders',
      exercises: [
        Exercise(name: 'Shoulder Press', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Lateral Raise', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Front Raise', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Rear Delt Fly', sets: "3", reps: "10", weight: "50"),
        Exercise(name: 'Shrug', sets: "3", reps: "10", weight: "50"),
      ],
    ),
  ];

  void initializeWorkoutList() {
    if (db.previousDataExist()) {
      workoutList = db.readFromDB();
    } else {
      db.saveToDb(workoutList);
    }
  }

// get the list of workout
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //get lenght of a given workout
  int getWorkoutLength(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  //add a new workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
    db.saveToDb(workoutList);
  }

  int numberOfExercises(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  // add a new exercise to a workout
  void addExercise(String workoutName, String exerciceName, String sets,
      String reps, String weight) {
    Workout relevantWorkout =
        getRelevantWorkout(workoutName); //get the relevant workout
    relevantWorkout.exercises.add(
      Exercise(
        name: exerciceName,
        sets: sets,
        reps: reps,
        weight: weight,
      ),
    );
    notifyListeners();
    db.saveToDb(workoutList);
  }

//check exercise
  void checkExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isDone = !relevantExercise.isDone;

    notifyListeners();
    db.saveToDb(workoutList);
  }

  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
