import 'package:checklist/models/day.dart';

class Quarantine {
  final DateTime start;
  final List<Day> days;

  Quarantine({required this.start, required this.days});

  factory Quarantine.fromJson(Map<String, dynamic> json) {
    return Quarantine(
      start: DateTime.parse(json["quarantineStart"].toString()),
      days: json["quarantineData"]
          .map<Day>((dayData) => Day.fromJson(dayData))
          .toList(),
    );
  }
}
