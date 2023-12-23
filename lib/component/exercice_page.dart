import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExercisePage extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String sets;
  final String reps;
  final bool isDone;

  final Function(bool?)? onchekboxChanged;

  const ExercisePage({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.sets,
    required this.reps,
    required this.isDone,
    required this.onchekboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Colors.black,
            Color.fromRGBO(117, 117, 117, 1),
            Color.fromRGBO(245, 242, 242, 1),
          ],
        ),
      ),
      child: ListTile(
        title: Text(exerciseName,
            style: const TextStyle(
              color: Color.fromRGBO(118, 255, 3, 1),
              fontWeight: FontWeight.bold,
            )),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Chip(
                  label: Text("${weight}kg",
                      style: const TextStyle(
                        // color: Color.fromRGBO(118, 255, 3, 1),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  elevation: 15,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  shadowColor: Colors.lightGreenAccent[400],
                ),
                const Gap(10),
                Chip(
                  label: Text("${sets}sets",
                      style: const TextStyle(
                        // color: Color.fromRGBO(118, 255, 3, 1),
                        color: Colors.black,

                        fontWeight: FontWeight.bold,
                      )),
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  shadowColor: Colors.lightGreenAccent[400],
                ),
                const Gap(10),
                Chip(
                  label: Text("${reps}reps",
                      style: const TextStyle(
                        // color: Color.fromRGBO(118, 255, 3, 1),
                        color: Colors.black,

                        fontWeight: FontWeight.bold,
                      )),
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  shadowColor: Colors.lightGreenAccent[400],
                ),
              ],
            ),
            Checkbox(
              value: isDone,
              onChanged: (val) => onchekboxChanged!(val),
            ),
          ],
        ),
      ),
    );
  }
}
