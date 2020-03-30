import 'package:flutter/material.dart';
import './enter.dart';
import '../mainpage.dart';

String _loginInput;
String _passwordInput;
bool passController = false; // Проверка аутентификации.

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextStyle style = TextStyle(
      color: Colors.lightBlueAccent,
      fontFamily: 'Montserrat',
      fontSize: 25,
      fontWeight: FontWeight.bold);

  Future<void> chageController() async {
    await logIn(_loginInput, _passwordInput).then((_) {
      print("PassControler is $passController");
      if (passController) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginField = TextFormField(
      obscureText: false,
      style: style,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        _loginInput = value;
      },
      decoration: InputDecoration(
          hintText: 'Login',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );
    final passwordField = TextFormField(
      obscureText: true, //Hiding an input text
      style: style,
      onChanged: (value) {
        _passwordInput = value;
      },
      decoration: InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );

    final enterButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.blueGrey[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          print("Button pressed!");
          chageController();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
          child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("PassStatus:" + passController.toString()),
            SizedBox(height: 30),
            Column(children: <Widget>[
              loginField,
              SizedBox(height: 30),
              passwordField
            ]),
            enterButton,
          ],
        ),
      )),
    );
  }
}
