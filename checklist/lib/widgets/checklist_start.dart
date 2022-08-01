import 'package:checklist/main.dart';
import 'package:flutter/material.dart';
import 'package:checklist/utils/quarantine.dart';

class ChecklistStart extends StatelessWidget {
  const ChecklistStart({Key? key}) : super(key: key);

  void handleStartQuarantine(BuildContext context) {
    startQuarantine().then((result) {
      if (result) {
        Navigator.pushNamedAndRemoveUntil(context, ChecklistScreen.routeName,
            (route) => route.settings.name != ChecklistScreen.routeName);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Quarantine created!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to create quarantine!")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "You have no ongoing quarantine",
          textAlign: TextAlign.center,
        ),
        TextButton(
          child: const Text("Start Quarantine"),
          onPressed: () => handleStartQuarantine(context),
        ),
      ],
    );
  }
}
