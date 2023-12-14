class Exercise {
  final String name;
  final int sets;
  final int reps;
  final int weight;
  bool isDone = false;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
