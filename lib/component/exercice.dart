class Exercise {
  final String name;
  final String sets;
  final String reps;
  final String weight;
  bool isDone;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    this.isDone = false,
  });

  // void toggleDone() {
  //   isDone = !isDone;
  // }
}
