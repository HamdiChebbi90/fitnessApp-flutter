import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String sets;
  final String reps;
  final bool isDone;
  final Function(bool?)? onchekboxChanged;
  const ExercisePage(
      {super.key,
      required this.exerciseName,
      required this.weight,
      required this.sets,
      required this.reps,
      required this.isDone,
      required this.onchekboxChanged,
      required Text title,
      required Row subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.redAccent,
          ],
        ),
      ),
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Chip(label: Text("${weight}kg")),
                Chip(label: Text("${sets}sets")),
                Chip(label: Text("${reps}reps")),
              ],
            ),
            Checkbox(
              value: isDone,
              onChanged: (value) => onchekboxChanged!(value),
            )
          ],
        ),
      ),
    );
  }
}
