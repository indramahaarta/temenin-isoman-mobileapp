import 'package:deteksi_mandiri/screens/create_question.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CreateAssessment extends StatefulWidget {
  String title = "";

  CreateAssessment(this.title, {Key? key}) : super(key: key);

  @override
  _CreateAssessmentState createState() => _CreateAssessmentState();
}

class _CreateAssessmentState extends State<CreateAssessment> {
  String name = "";
  String topic = "";
  // ignore: non_constant_identifier_names
  int number_of_question = 0;
  // ignore: non_constant_identifier_names
  int required_score_to_pass = 0;

  final GlobalKey<FormState> _createAssessmentForm = GlobalKey<FormState>();

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
      return Color(int.parse("0x$hexColor"));
    } else {
      return Color(int.parse("0x$hexColor"));
    }
  }

  Widget _buildHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: getColorFromHex("#344767"),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Name",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
      cursorColor: Colors.pink,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Name is required";
        }
      },
      onSaved: (String? value) {
        name = value ?? "";
      },
    );
  }

  Widget _buildTopic() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Topic",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
      cursorColor: Colors.pink,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Topic is required";
        }
      },
      onSaved: (String? value) {
        topic = value ?? "";
      },
    );
  }

  Widget _buildNumberOfQuestion() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Number Of Question",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
      cursorColor: Colors.pink,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Number Of Question is required";
        }

        try {
          int.parse(value);
        } on FormatException {
          return "Required Score to Pass must be an integer";
        }
      },
      onSaved: (String? value) {
        number_of_question = int.parse(value ?? "0");
      },
    );
  }

  Widget _buildRequiredScoreToPass() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Required Score to Pass",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
      cursorColor: Colors.pink,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Required Score to Pass is required";
        }

        try {
          int.parse(value);
        } on FormatException {
          return "Required Score to Pass must be an integer";
        }
      },
      onSaved: (String? value) {
        required_score_to_pass = int.parse(value ?? "0");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Deteksi Mandiri"),
          backgroundColor: Colors.pink,
        ),
        body: ListView(
          shrinkWrap: true,
          reverse: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _createAssessmentForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildHeader(widget.title),
                    _buildName(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTopic(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildNumberOfQuestion(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildRequiredScoreToPass(),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_createAssessmentForm.currentState!.validate()) {
                          _createAssessmentForm.currentState?.save();

                          final response = await http.post(
                              Uri.parse(
                                  'https://temenin-isoman.herokuapp.com/deteksimandiri/create-assessment/save'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json;charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                "name": name,
                                "topic": topic,
                                "number_of_question":
                                    (number_of_question).toString(),
                                "required_score_to_pass":
                                    (required_score_to_pass).toString(),
                              }));

                          var data = jsonDecode(response.body);
                          var pk = data[0]["pk"];

                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CreateQuestion(
                                    name,
                                    topic,
                                    number_of_question,
                                    required_score_to_pass,
                                    pk)),
                          );
                        } else {
                          return;
                        }
                      },
                      child: const Text("Submit"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
