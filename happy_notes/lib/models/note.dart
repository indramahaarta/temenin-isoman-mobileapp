class Note {
  late String title;
  late String? sender;
  late String message;

  Note({
    required this.title,
    this.sender,
    required this.message,
  });

  // factory method is used to initialize the class with the parameter values of a JSON file
  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json["fields"]["title"],
        sender: json["fields"]["sender"],
        message: json["fields"]["message"],
      );

  Map<String, dynamic> toJson() =>
      {"title": title, "sender": sender, "message": message};
}
