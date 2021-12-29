// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:deteksi_mandiri/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AssessmentPage extends StatefulWidget {
  String name = "";
  int pk = 1;

  AssessmentPage(this.name, this.pk, {Key? key}) : super(key: key);

  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  var user_answer = [];

  late Future<User?> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  Future<List<dynamic>> fetchQuestion(int pk) async {
    var url = Uri.parse(
        'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessments/' +
            pk.toString());

    final response = await http.get(url);

    // return response.body;
    var data = jsonDecode(response.body);

    return data;
  }

  Future<List<dynamic>> fetchOption(int pk, int pkQue) async {
    var url = Uri.parse(
        'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessments/' +
            pk.toString() +
            '/' +
            pkQue.toString());

    final response = await http.get(url);

    // return response.body;
    var data = jsonDecode(response.body);

    return data;
  }

  Widget _buildCustomText(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHeader(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: getColorFromHex("#344767"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildQuestion(pk, name) {
    return FutureBuilder(
        future: fetchQuestion(pk),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var data = snapshot.data ?? [];

            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if (user_answer.length != data.length) user_answer.add("");

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(32, 15, 32, 0),
                    child: Column(children: [
                      _buildCustomText(data[index]["question"]),
                      _buildOption(pk, data[index]["pk"], index),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  );
                });
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        });
  }

  FutureBuilder _buildOption(int pk, int pkQuestion, int no) {
    return FutureBuilder(
        future: fetchOption(pk, pkQuestion),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var data = snapshot.data ?? [];

            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Option(no, data[index]["answer"]),
                        ]),
                  );
                });
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        });
  }

  Widget Option(int index, String data) {
    return RadioListTile<String>(
      value: data,
      groupValue: user_answer[index],
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      onChanged: (value) {
        setState(() {
          user_answer[index] = (value == null) ? "" : value;
        });
      },
      title: _buildCustomText(data),
      activeColor: Colors.pink,
    );
  }

  Widget _buildSubmit(int pk) {
    return ElevatedButton(
      onPressed: () async {
        if (validateData()) {
          final res = await futureUser;
          final response = await http.post(
              Uri.parse(
                  'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessments/' +
                      pk.toString() +
                      '/save'),
              headers: <String, String>{
                'Content-Type': 'application/json;charset=UTF-8',
              },
              body: jsonEncode(<String, List>{
                "answers": user_answer,
                "user": [res?.username]
              }));

          var data = jsonDecode(response.body);

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ResultPage(data)),
          );
        } else {
          showAlertDialog(context);
        }
      },
      child: const Text("Submit"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.pink),
      ),
    );
  }

  validateData() {
    for (String data in user_answer) {
      if (data == "") {
        return false;
      }
    }
    return true;
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("WARNING"),
      content: const Text("Answer all the questions!!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
      return Color(int.parse("0x$hexColor"));
    } else {
      return Color(int.parse("0x$hexColor"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deteksi Mandiri',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              )),
          elevation: 5.0,
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildHeader(widget.name),
              _buildQuestion(widget.pk, widget.name),
              _buildSubmit(widget.pk),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
