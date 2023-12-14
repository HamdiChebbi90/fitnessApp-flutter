import 'dart:math';

import 'package:fitnessapp/component/exercice.dart';
import 'package:fitnessapp/component/exercice_page.dart';
import 'package:fitnessapp/component/workout.dart';
import 'package:fitnessapp/data/date.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDB {
  final _myBox = Hive.box("db");
//check if there id already data stored
  bool previousDataExist() {
    if (_myBox.isEmpty) {
      print("previous data does not exist");
      _myBox.put("Start_date", todayDate());
      return false;
    } else {
      print("previous data exist");
      return true;
    }
  }

//return start day as yymmdd
  String getStartDate() {
    return _myBox.get("Start_Date");
  }

//writet data
  void saveToDb(List<Workout> workout) {
    final workoutList = workoutToList(workout);
    final exerciseList = exerciseToList(workout);

    if (exerciseCompleted(workout)) {
      _myBox.put("Completion _status${todayDate()}", 1);
    } else {
      _myBox.put("Completion _status${todayDate()}", 0);
    }

//save into Hive
    _myBox.put("Workouts", workoutList);
    _myBox.put("Exercices", exerciseList);
  }

//read date form db
  List<Workout> readFromDB() {
    List<Workout> mySavedWorkouts = [];
    List<String> workoutNames = _myBox.get("Workouts");
    List exerciceNames = _myBox.get("Exercices");

    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exerciseInEachWorkout = [];
      for (int j = 0; j < exerciceNames[i].length; j++) {
        exerciseInEachWorkout.add(Exercise(
            name: exerciceNames[i][j][0],
            sets: int.parse(exerciceNames[i][j][1]),
            reps: int.parse(exerciceNames[i][j][2]),
            weight: int.parse(exerciceNames[i][j][3]),
            isDone: exerciceNames[i][j][4] == "true" ? true : false));
      }
      Workout workout =
          Workout(name: workoutNames[i], exercises: exerciseInEachWorkout);
      mySavedWorkouts.add(workout);
    }

    return mySavedWorkouts;
  }

  int getCompletionStatus(String dateFormat) {
    int completionStatus = _myBox.get("Completion _status${dateFormat}");
    return completionStatus;
  }

//return completed exercice
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

//convert workout into list
  List<String> workoutToList(List<Workout> workouts) {
    List<String> workoutList = [];
    for (int i = 0; i < workouts.length; i++) {
      workoutList.add(workouts[i].name);
    }
    return workoutList;
  }

//convert Exercise into list
  List<List<List<String>>> exerciseToList(List<Workout> workouts) {
    List<List<List<String>>> exerciseList = [];
    for (int i = 0; i < workouts.length; i++) {
//get exercise from each workout
      List<Exercise> exercisesWorkout = workouts[i].exercises;
      List<List<String>> individualWorkout = [];
      for (int j = 0; j < exercisesWorkout.length; j++) {
        List<String> individualExercise = [];
        individualExercise.addAll([
          exercisesWorkout[j].name,
          exercisesWorkout[j].sets.toString(),
          exercisesWorkout[j].reps.toString(),
          exercisesWorkout[j].weight.toString()
        ]);
        individualWorkout.add(individualExercise);
      }
      exerciseList.add(individualWorkout);
    }
    return exerciseList;
  }
}
