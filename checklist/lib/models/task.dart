class Task {
  final int id;
  final String title;
  final String description;
  bool done;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.done,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      done: json["done"],
    );
  }
}
