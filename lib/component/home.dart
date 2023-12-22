import 'package:fitnessapp/component/workout_page.dart';
import 'package:fitnessapp/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final newWorkoutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  void CreateNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Create New Workout"),
          content: TextField(
            controller: newWorkoutController,
            decoration: const InputDecoration(
              labelText: "Workout Name",
            ),
          ),
          actions: [
            MaterialButton(onPressed: save, child: const Text("Save")),
            MaterialButton(onPressed: canel, child: const Text("Cancel")),
          ]),
    );
  }

  //save workout
  void save() {
    String newWorkoutName = newWorkoutController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
    // GoTo(newWorkoutName);

    newWorkoutController.clear();
  }

  //cancel workout
  void canel() {
    Navigator.pop(context);
  }

  //go to workout
  GoTo(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[400],
            centerTitle: true,
            title: const Text(
              "Fitness App",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[400],
            onPressed: CreateNewWorkout,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(value.getWorkoutList()[index].name),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  GoTo(value.getWorkoutList()[index].name);
                },
              );
            },
          ),
        );
      },
    );
  }
}
