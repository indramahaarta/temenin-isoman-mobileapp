import 'package:checklist/widgets/modules/day_item.dart';
import 'package:checklist/widgets/modules/task_item.dart';
import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';

import 'package:checklist/models/quarantine.dart';

class ChecklistRunning extends StatefulWidget {
  final Quarantine quarantine;

  const ChecklistRunning({
    Key? key,
    required this.quarantine,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChecklistRunningState();
}

class _ChecklistRunningState extends State<ChecklistRunning> {
  int getCurrentDay() =>
      DateTime.now().difference(widget.quarantine.start).inDays;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Running Quarantine",
            textAlign: TextAlign.center,
            style: AppTheme.myTextTheme.headline5,
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: List.of(
              widget.quarantine.days.map(
                (day) => DayItem(
                  day: day,
                  quarantineStart: widget.quarantine.start,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "Your checklist:",
            textAlign: TextAlign.center,
            style: AppTheme.myTextTheme.headline6,
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            children: List.of(
              widget.quarantine.days
                  .firstWhere((day) => getCurrentDay() == day.day - 1)
                  .tasks
                  .map((task) => TaskItem(task: task)),
            ),
          ),
        ],
      ),
    );
  }
}
