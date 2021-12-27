import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/session.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';
import 'package:temenin_isoman_mobileapp/screens/home_screen.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<User?> futureUser;

  String _username = "";
  String _password = "";
  bool _showPassword = true;

  void login() async {
    if (_username == "" || _password == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter user name and password!")));
      return;
    }

    final sessionCookie = await getSessionIdCookie();
    final response = await http.post(
        Uri.parse("https://temenin-isoman.herokuapp.com/user/login"),
        headers: sessionCookie,
        body: {
          "username": _username,
          "password": _password,
        });

    if (response.statusCode == 200) {
      updateSessionId(response);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login success!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login failed!")));
    }
  }

  @override
  void initState() {
    super.initState();

    futureUser = fetchUser();
    futureUser.then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    });
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
      drawer: customDrawer(context, futureUser),
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
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (value) => setState(() => _username = value),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: _showPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) => setState(() => _password = value),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: login,
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
                      onPressed: () {},
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
