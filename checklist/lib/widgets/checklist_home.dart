import 'package:flutter/material.dart';

import 'package:checklist/widgets/checklist_running.dart';
import 'package:checklist/widgets/checklist_start.dart';

import 'package:checklist/models/quarantine.dart';
import 'package:checklist/utils/quarantine.dart';

class ChecklistHome extends StatefulWidget {
  const ChecklistHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChecklistHomeState();
}

class _ChecklistHomeState extends State<ChecklistHome> {
  late Future<Quarantine?> futureQuarantine;

  @override
  void initState() {
    super.initState();
    futureQuarantine = fetchQuarantine();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureQuarantine,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChecklistRunning(quarantine: snapshot.data! as Quarantine);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          return const ChecklistStart();
        } else if (snapshot.hasError) {
          return const Text("Error!");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
