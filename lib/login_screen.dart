import 'package:flutter/material.dart';
import './enter.dart';

String loginInput;
String passwordInput;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(
      color: Colors.lightBlueAccent,
      fontFamily: 'Montserrat',
      fontSize: 25,
      fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final loginField = TextFormField(
      obscureText: false,
      style: style,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        loginInput = value;
      },
      decoration: InputDecoration(
          hintText: 'Login',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );
    final passwordField = TextFormField(
      obscureText: true, //Hiding an input text
      style: style,
      onChanged: (value) {
        loginInput = value;
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
        onPressed: () => log_in(loginInput, passwordInput), //TODO: request
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
