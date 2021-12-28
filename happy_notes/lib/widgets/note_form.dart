import 'package:flutter/material.dart';
import 'package:happy_notes/methods/add_data.dart';
import 'package:happy_notes/models/note.dart';
import 'package:happy_notes/happy_notes.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({Key? key}) : super(key: key);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late String title;
  late String sender;
  late String message;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Add Note',
        textAlign: TextAlign.center,
      ),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Please enter note title";
              }
              title = value!;
            },
            decoration: const InputDecoration(
              hintText: "Enter note title",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Please enter sender's name or alias";
              }
              sender = value!;
            },
            decoration: const InputDecoration(
              hintText: "Enter sender's name or alias",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Please enter the message";
              }
              message = value!;
            },
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Enter the message",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Note newNote = Note(
                  title: title,
                  sender: sender,
                  message: message,
                );
                addNewNote(newNote).then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      value,
                    ))));
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NotesPage();
                }));
              }
            },
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 16),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.red)))),
          ),
        ]),
      ),
    );
  }
}
