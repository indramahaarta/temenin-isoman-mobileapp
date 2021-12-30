import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';

import 'package:checklist/models/day.dart';

class DayItem extends StatelessWidget {
  final Day day;
  final DateTime quarantineStart;

  final num currentDay;

  DayItem({
    Key? key,
    required this.day,
    required this.quarantineStart,
  })  : currentDay = DateTime.now().difference(quarantineStart).inDays,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentDay == day.day
            ? Colors.pink.shade300
            : currentDay > day.day
                ? Colors.green.shade300
                : Colors.blue.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Day"),
            const SizedBox(height: 2),
            Text(
              day.day.toString(),
              style: AppTheme.myTextTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
