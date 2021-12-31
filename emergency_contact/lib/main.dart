import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:emergency_contact/common/styles.dart';
import 'package:emergency_contact/screens/list_daerah.dart';
// import 'package:url_launcher/url_launcher.dart';

class EmergencyContactPage extends StatefulWidget {
  static const routeName = '/emergency-contact';
  const EmergencyContactPage({Key? key}) : super(key: key);

  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late Future<User?> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(context, futureUser),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkSecondaryColor,
        title: Text(
          'Emergency Contact',
          style: myTextTheme.headline6,
        ),
      ),
      body: Container(
        // alignment: ,
        child: FutureBuilder(
          future: futureUser,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0),
                child: Text(
                  "Login terlebih dahulu untuk dapat mengakses emergency contact.",
                ),
              );
            }
            return const ListDaerahPage();
          },
        ),
      ),
      // body: Container(
      //   alignment: Alignment.center,
      //   child: const Text("Test"),
      // ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.call),
          tooltip: 'Telepon hotline utama Covid-19',
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Widget cancelButton = TextButton(
                        child: const Text("Tidak"),
                        onPressed: () {},
                      );
                      Widget launchButton = TextButton(
                        child: const Text("Ya"),
                        onPressed: () {},
                        // onPressed: () => launch("tel://21213123123"),
                      );
                      return AlertDialog(
                        title: const Text("Hotline Covid-19 (119)"),
                        content: const Text(
                            "Apakah Anda ingin langsung tersambung ke hotline utama Covid-19?"),
                        actions: [
                          cancelButton,
                          launchButton,
                        ],
                      );
                    })
              }),
    );
  }
}
