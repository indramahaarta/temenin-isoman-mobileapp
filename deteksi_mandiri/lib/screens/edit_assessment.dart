import 'package:deteksi_mandiri/screens/edit_question.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditAssessment extends StatefulWidget {
  String title = "";
  int pk = 0;
  String name = "";
  String topic = "";
  int number_of_question = 0;
  int required_score_to_pass = 0;

  EditAssessment(this.title, this.pk, this.name, this.topic,
      this.number_of_question, this.required_score_to_pass);

  @override
  _EditAssessmentState createState() => _EditAssessmentState();
}

class _EditAssessmentState extends State<EditAssessment> {
  String name = "";
  String topic = "";
  int number_of_question = 0;
  int required_score_to_pass = 0;

  final GlobalKey<FormState> _editAssessmentForm = GlobalKey<FormState>();

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
        SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget _buildName() {
    return TextFormField(
      initialValue: widget.name,
      decoration: InputDecoration(
        labelText: "Name",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Name is required";
        }
      },
      onSaved: (String? value) {
        name = value ?? "";
      },
      cursorColor: Colors.pink,
    );
  }

  Widget _buildTopic() {
    return TextFormField(
      initialValue: widget.topic,
      decoration: InputDecoration(
        labelText: "Topic",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Topic is required";
        }
      },
      onSaved: (String? value) {
        topic = value ?? "";
      },
      cursorColor: Colors.pink,
    );
  }

  Widget _buildNumberOfQuestion() {
    return TextFormField(
      initialValue: widget.number_of_question.toString(),
      decoration: InputDecoration(
        labelText: "Number Of Question",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
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
      cursorColor: Colors.pink,
    );
  }

  Widget _buildRequiredScoreToPass() {
    return TextFormField(
      initialValue: widget.required_score_to_pass.toString(),
      decoration: InputDecoration(
        labelText: "Required Score to Pass",
        labelStyle: TextStyle(color: Colors.pink),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.4,
          ),
        ),
      ),
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
      cursorColor: Colors.pink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Deteksi Mandiri"),
          backgroundColor: Colors.pink,
        ),
        body: ListView(
          shrinkWrap: true,
          reverse: true,
          children: [
            Padding(
              padding: EdgeInsets.all(32),
              child: Form(
                key: _editAssessmentForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildHeader(widget.title),
                    _buildName(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTopic(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildNumberOfQuestion(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildRequiredScoreToPass(),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_editAssessmentForm.currentState!.validate()) {
                          _editAssessmentForm.currentState?.save();

                          final response = await http.post(
                              Uri.parse(
                                  'https://temenin-isoman.herokuapp.com/deteksimandiri/edit-assessment/' +
                                      widget.pk.toString() +
                                      '/save'),
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

                          // get-assessments/<pk>

                          final response2 = await http.get(
                            Uri.parse(
                                'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessments/' +
                                    widget.pk.toString()),
                          );

                          var data2 = jsonDecode(response2.body);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => EditQuestion(
                                    name,
                                    topic,
                                    number_of_question,
                                    required_score_to_pass,
                                    pk,
                                    data2)),
                          );
                        } else {
                          return;
                        }
                      },
                      child: Text("Submit"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
