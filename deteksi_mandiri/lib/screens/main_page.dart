import 'dart:convert';

import 'package:deteksi_mandiri/screens/assessment_test_page.dart';
import 'package:deteksi_mandiri/screens/create_assessment.dart';
import 'package:deteksi_mandiri/screens/edit_assessment.dart';
import 'package:deteksi_mandiri/screens/question_view.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  static const routeName = '/deteksi-mandiri';

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<User?> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
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

  Future<List<dynamic>> fetchAssessment() async {
    var url = Uri.parse(
        'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessments/');

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
          "Assessment List",
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

  showAlertDialog(BuildContext context, String data, int pk, String action) {
    String getContentText(String action, String data) {
      if (action == "start_assessment") {
        return "Are you sure want to start " + data + " ?";
      } else {
        return "Are you sure want to delete " + data + " ?";
      }
    }

    getOnPressedAction(String action) {
      if (action == "start_assessment") {
        return () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AssessmentPage(data, pk)),
          );
        };
      } else {
        return () async {
          await http.post(
              Uri.parse(
                  'https://temenin-isoman.herokuapp.com/deteksimandiri/delete-assessments/' +
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
        };
      }
    }

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
      child: const Text("Yes", style: TextStyle(color: Colors.pink)),
      onPressed: getOnPressedAction(action),
    );

    AlertDialog alert = AlertDialog(
      title: const Text("WARNING"),
      content: Text(getContentText(action, data)),
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

  showAlertWarningDialog(BuildContext context) {
    Widget continueButton = TextButton(
        child: const Text("Yes", style: TextStyle(color: Colors.pink)),
        onPressed: () {
          Navigator.of(context).pop();
        });

    AlertDialog alert = AlertDialog(
      title: const Text("FAILED"),
      content: const Text("You need login to start this Assessment!"),
      actions: [
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
        future: fetchAssessment(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var data = snapshot.data ?? [];
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: futureUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ElevatedButton(
                              onPressed: () {
                                showAlertDialog(
                                    context,
                                    data[index]['fields']["name"],
                                    data[index]["pk"],
                                    "start_assessment");
                              },
                              style: ButtonStyle(
                                visualDensity: const VisualDensity(
                                    vertical: -1, horizontal: -1),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.pink),
                              ),
                              child: Text(
                                data[index]["fields"]["name"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () {
                              showAlertWarningDialog(context);
                            },
                            style: ButtonStyle(
                              visualDensity: const VisualDensity(
                                  vertical: -1, horizontal: -1),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink),
                            ),
                            child: Text(
                              data[index]["fields"]["name"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: futureUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              ((snapshot.data as User)
                                      .roles
                                      .contains("fasilitas_kesehatan") ||
                                  (snapshot.data as User)
                                      .roles
                                      .contains("admin"))) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  OutlinedButton(
                                    onPressed: () async {
                                      final response = await http.get(
                                        Uri.parse(
                                            'https://temenin-isoman.herokuapp.com/deteksimandiri/get-assessment/' +
                                                data[index]["pk"].toString()),
                                      );

                                      List d = jsonDecode(response.body);

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => EditAssessment(
                                                "Edit Assessment",
                                                data[index]["pk"],
                                                d[0]["name"],
                                                d[0]["topic"],
                                                d[0]["nomber_of_question"],
                                                d[0][
                                                    "required_score_to_pass"])),
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
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => QuestionView(
                                                data[index]["pk"])),
                                      );
                                    },
                                    style: const ButtonStyle(
                                      visualDensity: VisualDensity(
                                          vertical: -3, horizontal: -4),
                                    ),
                                    child: const Text(
                                      'Show Questions',
                                      style: TextStyle(
                                        color: Colors.blue,
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
                                          data[index]['fields']["name"],
                                          data[index]["pk"],
                                          "delete_assessment");
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
                            );
                          }
                          return const SizedBox(
                            height: 15,
                          );
                        },
                      ),
                    ],
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          );
        });
  }

  Widget? _buildFloatingButton() {
    return FutureBuilder(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            ((snapshot.data as User).roles.contains("fasilitas_kesehatan") ||
                (snapshot.data as User).roles.contains("admin"))) {
          return FloatingActionButton(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            mini: false,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        CreateAssessment("Create Assessment")),
              );
            },
            child: const Icon(Icons.add),
          );
        }
        return const Text("");
      },
    );
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
      drawer: customDrawer(context, futureUser),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(),
            _buildContent(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingButton(),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
