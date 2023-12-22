import 'dart:math';

import 'package:fitnessapp/component/exercice.dart';
import 'package:fitnessapp/component/exercice_page.dart';
import 'package:fitnessapp/component/workout.dart';
import 'package:fitnessapp/data/date.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDB {
  final _myBox = Hive.box("workout_db");
////////////check if there id already data stored
  bool previousDataExist() {
    if (_myBox.isEmpty) {
      print("previous data does not exist");
      _myBox.put("Start_date", todayDateYMD());
      return false;
    } else {
      print("previous data exist");
      return true;
    }
  }

///////////////return start day as yymmdd
  String getStartDate() {
    return _myBox.get("Start_Date");
  }

//////////////////////writet data
  void saveToDb(List<Workout> workouts) {
    final workoutList = convertObjectToworkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    //check if exercise is completed
    if (exerciseCompleted(workouts)) {
      _myBox.put("Completion _status${todayDateYMD()}", 1);
    } else {
      _myBox.put("Completion _status${todayDateYMD()}", 0);
    }

    //save into Hive
    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCICES", exerciseList);
  }

/////////////////read date form db
  List<Workout> readFromDB() {
    List<Workout> mySavedWorkouts = [];

    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciceDetails = _myBox.get("EXERCICES");

    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exerciseInEachWorkout = [];
      for (int j = 0; j < exerciceDetails[i].length; j++) {
        exerciseInEachWorkout.add(
          Exercise(
            name: exerciceDetails[i][j][0],
            sets: exerciceDetails[i][j][1],
            reps: exerciceDetails[i][j][2],
            weight: exerciceDetails[i][j][3],
            isDone: exerciceDetails[i][j][4] == "true" ? true : false,
          ),
        );
      }
      Workout workout =
          Workout(name: workoutNames[i], exercises: exerciseInEachWorkout);
      mySavedWorkouts.add(workout);
    }

    return mySavedWorkouts;
  }

  int getCompletionStatus(String yymmdd) {
    return _myBox.get("Completion _status$yymmdd") ?? 0;
  }

/////////////return completed exercice
  bool exerciseCompleted(List<Workout> workouts) {
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isDone) {
          return true;
        }
      }
    }
    return false;
  }
}

//////////////convert workout into list
List<String> convertObjectToworkoutList(List<Workout> workouts) {
  List<String> workoutList = [];
  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(workouts[i].name);
  }
  return workoutList;
}

///////////////convert Exercise into list
List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];
  for (int i = 0; i < workouts.length; i++) {
//get exercise from each workout
    List<Exercise> exercisesInWorkout = workouts[i].exercises;

//convert exercise into list
    List<List<String>> individualWorkout = [];

    for (int j = 0; j < exercisesInWorkout.length; j++) {
      List<String> individualExercise = [];
      individualExercise.addAll([
        exercisesInWorkout[j].name,
        exercisesInWorkout[j].sets,
        exercisesInWorkout[j].reps,
        exercisesInWorkout[j].weight,
        exercisesInWorkout[j].isDone.toString(),
      ]);
      individualWorkout.add(individualExercise);
    }
    exerciseList.add(individualWorkout);
  }
  return exerciseList;
}
