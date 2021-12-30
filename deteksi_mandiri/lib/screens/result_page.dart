import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResultPage extends StatelessWidget {
  var data = [];

  ResultPage(this.data, {Key? key}) : super(key: key);

  Widget _buildSummary(result) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: pickColor((result[index]["truth"]).toString()),
                  width: 10000,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    result[index]["question"] + " | " + result[index]["answer"],
                    style: TextStyle(color: Colors.grey.shade200),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  String diagnosed(lulus) {
    if (lulus == "true") {
      return "Negative";
    } else {
      return "Positive";
    }
  }

  String advise(lulus) {
    if (lulus == "true") {
      return "Congratulations. You have a low risk of becoming infected with CODIV-19. Stay healthy! :D";
    } else {
      return "You have a high risk of getting infected with COVID-19. Immediately consider contacting the hospital for a swab test!";
    }
  }

  Color pickColor(truth) {
    if (truth == "true") {
      return Colors.green;
    } else {
      return Colors.red;
    }
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

  // ignore: non_constant_identifier_names
  Widget CustomText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
      ),
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink,
      ),
      body: Padding(
          padding: const EdgeInsets.all(32),
          child: ListView(children: <Widget>[
            Center(
                child: Text(
              'Assessment Result',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: getColorFromHex("#344767")),
            )),
            const SizedBox(
              height: 10,
            ),
            DataTable(
              horizontalMargin: 0,
              columns: const [
                DataColumn(
                    label: Text('Test',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Description',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('Assessment')),
                  DataCell(Text(data[0]["assessment"])),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Score to Pass')),
                  DataCell(Text((data[0]["score_to_pass"]).toString())),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Your Score')),
                  DataCell(Text((data[0]["score"]).toString())),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Diagnosed')),
                  DataCell(Text(diagnosed((data[0]["lulus"]).toString()))),
                ]),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            CustomText(advise((data[0]["lulus"]).toString())),
            const SizedBox(
              height: 17,
            ),
            Column(
              children: [
                Text(
                  "Summary",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: getColorFromHex("#344767")),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildSummary(data[0]["result"]),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/deteksi-mandiri", (r) => false);
                  },
                  child: const Text("Go Back"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink),
                  ),
                ),
              ],
            )
          ])),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
