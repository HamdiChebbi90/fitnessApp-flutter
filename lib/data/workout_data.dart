import 'package:fitnessapp/component/exercice.dart';
import 'package:fitnessapp/component/workout.dart';
import 'package:fitnessapp/data/hive_db.dart';
import 'package:flutter/material.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDB();

  List<Workout> workoutList = [
    Workout(
      name: "Chest",
      exercises: [
        Exercise(
          name: "Bench Press",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Incline Bench Press",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Decline Bench Press",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Dumbbell Fly",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Cable Fly",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
      ],
    ),
    Workout(
      name: "Back",
      exercises: [
        Exercise(
          name: "Deadlift",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Pull Up",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Lat Pulldown",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Seated Row",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Dumbbell Row",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
      ],
    ),
    Workout(
      name: "Legs",
      exercises: [
        Exercise(
          name: "Squat",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Leg Press",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Leg Extension",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Leg Curl",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Calf Raise",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
      ],
    ),
    Workout(
      name: "Shoulders",
      exercises: [
        Exercise(
          name: "Shoulder Press",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Lateral Raise",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Front Raise",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Rear Delt Fly",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
        Exercise(
          name: "Shrug",
          sets: 4,
          reps: 8,
          weight: 60,
        ),
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

  // add a new exercise
  void addExercise(
      String workoutName, String exerciceName, int sets, int reps, int weight) {
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
        workoutList.firstWhere((element) => element.name == workoutName);
    return relevantWorkout;
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((element) => element.name == exerciseName);
    return relevantExercise;
  }
}
