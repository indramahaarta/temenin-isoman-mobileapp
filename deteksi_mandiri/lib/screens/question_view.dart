import 'dart:convert';

import 'package:deteksi_mandiri/screens/edit_option.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class QuestionView extends StatefulWidget {
  int pk = 0;

  QuestionView(this.pk, {Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
      return Color(int.parse("0x$hexColor"));
    } else {
      return Color(int.parse("0x$hexColor"));
    }
  }

  Future<List<dynamic>> fetchQuestion(int pk) async {
    var url = Uri.parse(
        'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessments/' +
            widget.pk.toString());

    final response = await http.get(url);
    var data = jsonDecode(response.body);

    return data;
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          "Question List",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: getColorFromHex("#344767"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context, String data, int pk) {
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(color: Colors.pink),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(color: Colors.pink),
      ),
      onPressed: () async {
        await http.post(
            Uri.parse(
                'https://temenin-isoman.herokuapp.com/deteksimandiri/delete-question/' +
                    pk.toString()),
            headers: <String, String>{
              'Content-Type': 'application/json;charset=UTF-8',
            },
            body: jsonEncode(<String, List>{
              "pk": [pk]
            }));
        Navigator.of(context).pop();
        setState(() {
          _buildContent();
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("WARNING"),
      content: Text("Are you sure want to delete " + data),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildContent() {
    return FutureBuilder(
        future: fetchQuestion(widget.pk),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var data = snapshot.data ?? [];
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(32, 15, 32, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Text(data[index]['question']),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OutlinedButton(
                                onPressed: () async {
                                  final response = await http.get(
                                    Uri.parse(
                                        'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessments/' +
                                            widget.pk.toString() +
                                            '/' +
                                            data[index]["pk"].toString()),
                                  );

                                  List d = jsonDecode(response.body);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => EditOption(
                                            widget.pk, data[index]["pk"], d)),
                                  );
                                },
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity(
                                      vertical: -3, horizontal: -4),
                                ),
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  showAlertDialog(
                                      context,
                                      data[index]['question'],
                                      data[index]["pk"]);
                                },
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity(
                                      vertical: -3, horizontal: -4),
                                ),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            );
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
          children: [
            _buildHeader(),
            _buildContent(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
