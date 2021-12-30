import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CreateQuestion extends StatefulWidget {
  String name = "";
  String topic = "";
  // ignore: non_constant_identifier_names
  int number_of_question = 0;
  // ignore: non_constant_identifier_names
  int required_score_to_pass = 0;
  int pk = 0;

  CreateQuestion(this.name, this.topic, this.number_of_question,
      this.required_score_to_pass, this.pk,
      {Key? key})
      : super(key: key);

  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  // ignore: non_constant_identifier_names
  List user_question = [];

  final GlobalKey<FormState> _createQuestionForm = GlobalKey<FormState>();

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
      return Color(int.parse("0x$hexColor"));
    } else {
      return Color(int.parse("0x$hexColor"));
    }
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Create Question",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: getColorFromHex("#344767"),
          ),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }

  Widget _buildTextFormField(int index) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Question " + index.toString(),
            labelStyle: const TextStyle(color: Colors.pink),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink,
                width: 1.4,
              ),
            ),
          ),
          cursorColor: Colors.pink,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "This field can't be empty";
            }
          },
          onSaved: (String? value) {
            user_question[index - 1] = value;
          },
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _buildInput() {
    return Column(
      children: List.generate(
          widget.number_of_question, (index) => _buildTextFormField(index + 1)),
    );
  }

  Widget _buildButton() {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              if (_createQuestionForm.currentState!.validate()) {
                _createQuestionForm.currentState?.save();

                await http.post(
                    Uri.parse(
                        'https://temenin-isoman.herokuapp.com/deteksimandiri/create-assessment/' +
                            widget.pk.toString() +
                            '/create-question' +
                            '/save'),
                    headers: <String, String>{
                      'Content-Type': 'application/json;charset=UTF-8',
                    },
                    body: jsonEncode(<String, List>{
                      "data": user_question,
                    }));

                Navigator.pushNamedAndRemoveUntil(
                    context, "/deteksi-mandiri", (r) => false);
              } else {
                return;
              }
            },
            child: const Text('Submit'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink),
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    while (user_question.length < widget.number_of_question) {
      user_question.add("");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deteksi Mandiri"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
              key: _createQuestionForm,
              child: ListView(
                children: [
                  _buildHeader(),
                  _buildInput(),
                  _buildButton(),
                ],
              ))),
    );
  }
}
