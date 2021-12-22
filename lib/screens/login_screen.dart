import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:temenin_isoman_mobileapp/common/styles.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';

import 'package:temenin_isoman_mobileapp/utils/session.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  void fetchUser() async {
    final response = await http
        .post(Uri.parse("https://temenin-isoman.herokuapp.com/user/dummy"));

    print(response.statusCode);
    print(response.body);

    final responseLogin = await http.post(
        Uri.parse("https://temenin-isoman.herokuapp.com/user/login"),
        body: {"username": "admin", "password": "bebasss123"});
    print(responseLogin.statusCode);
    print(responseLogin.body);

    updateSessionId(responseLogin);

    String? sessionId = await getSessionId();
    final responseDummy = await http.post(
        Uri.parse("https://temenin-isoman.herokuapp.com/user/dummy"),
        headers: sessionId != null
            ? {
                "cookie": "sessionid=$sessionId",
              }
            : {});
    print(responseDummy.statusCode);
    print(responseDummy.body);

    final responseLogout = await http
        .post(Uri.parse("https://temenin-isoman.herokuapp.com/user/logout"));
    print(responseLogout.statusCode);
    print(responseLogout.body);
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Temenin Isoman"),
        backgroundColor: AppTheme.primaryColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.short_text,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: customDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 60.0,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    color: Colors.pink,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: Colors.black,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // print('Sign Up');
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
