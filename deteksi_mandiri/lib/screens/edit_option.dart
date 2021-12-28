import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditOption extends StatefulWidget {
  int pk1 = 0;
  int pk2 = 0;
  List data = [];

  EditOption(this.pk1, this.pk2, this.data);

  @override
  _EditOptionState createState() => _EditOptionState();
}

class _EditOptionState extends State<EditOption> {
  List user_option = [];

  final GlobalKey<FormState> _editQuestionForm = GlobalKey<FormState>();

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
          "Edit Option",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: getColorFromHex("#344767"),
          ),
        ),
        SizedBox(
          height: 32,
        )
      ],
    );
  }

  Widget _buildTextFormField(int index) {
    return Column(
      children: [
        TextFormField(
          initialValue: user_option[index - 1]["answer"],
          decoration: InputDecoration(
            labelText: "Answer " + index.toString(),
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
            if (!user_option[index - 1]["delete"]) {
              if (value == null || value.isEmpty) {
                if (user_option[index - 1]["pk"] != null) {
                  return "Answer " + index.toString() + " is required";
                }
              }
            }
          },
          onSaved: (String? value) {
            user_option[index - 1]["answer"] = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: user_option[index - 1]["poin"].toString(),
          decoration: InputDecoration(
            labelText: "Poin",
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
            if (!user_option[index - 1]["delete"]) {
              if (value == null || value.isEmpty) {
                if (user_option[index - 1]["pk"] != null) {
                  return "Poin is required";
                }
              } else {
                try {
                  int.parse(value);
                } on FormatException {
                  return "Required Score to Pass must be an integer";
                }
              }
            }
          },
          onSaved: (String? value) {
            user_option[index - 1]["poin"] = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Correct",
                  style: TextStyle(color: Colors.pink),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  value: user_option[index - 1]["correct"],
                  onChanged: (bool? value) {
                    setState(() {
                      user_option[index - 1]["correct"] = value!;
                    });
                  },
                  activeColor: Colors.pink,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Delete",
                  style: TextStyle(color: Colors.pink),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  value: user_option[index - 1]["delete"],
                  onChanged: (bool? value) {
                    setState(() {
                      user_option[index - 1]["delete"] = value!;
                    });
                  },
                  activeColor: Colors.pink,
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget _buildInput() {
    return Column(
      children: List.generate(5, (index) => _buildTextFormField(index + 1)),
    );
  }

  Widget _buildButton() {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              if (_editQuestionForm.currentState!.validate()) {
                _editQuestionForm.currentState?.save();

                final response = await http.post(
                    Uri.parse(
                        'https://temenin-isoman.herokuapp.com/deteksimandiri/save-options/'),
                    headers: <String, String>{
                      'Content-Type': 'application/json;charset=UTF-8',
                    },
                    body: jsonEncode(<String, List>{
                      "data": user_option,
                    }));

                Navigator.of(context).pop();
              } else {
                return;
              }
            },
            child: Text('Submit'),
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
    for (int i = 0; i < widget.data.length; i++) {
      user_option.add(widget.data[i]);
    }

    for (int i = user_option.length; i < 5; i++) {
      user_option.add({
        "answer": "",
        "poin": "",
        "correct": false,
        "delete": false,
        "question": widget.pk2
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Deteksi Mandiri"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
          padding: EdgeInsets.all(32),
          child: Form(
              key: _editQuestionForm,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildHeader(),
                  _buildInput(),
                  _buildButton(),
                ],
              ))),
    );
  }
}
