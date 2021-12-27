import 'package:checklist/models/task.dart';

class Day {
  final int id;
  final int day;
  final List<Task> tasks;

  Day({required this.id, required this.day, required this.tasks});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json["id"],
      day: json["day"],
      tasks: json["tasks"]
          .map<Task>((taskData) => Task.fromJson(taskData))
          .toList(),
    );
  }
}
