import 'package:checklist/widgets/modules/day_item.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Running Quarantine",
            textAlign: TextAlign.center,
            style: AppTheme.myTextTheme.headline5,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
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
          ),
        ],
      ),
    );
  }
}
