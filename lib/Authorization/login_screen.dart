import 'package:flutter/material.dart';
import 'package:shared/Helpers/cards.dart';
import 'package:shared/Pages/account.dart';
import '../Helpers/enter.dart';
import '../mainpage.dart';
import './registry.dart';

String _loginInput;
String user_id;
String _passwordInput;
bool passController = false; // Проверка аутентификации.

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextStyle style = TextStyle(
      color: Colors.black,
      fontFamily: 'Montserrat',
      fontSize: 25,
      fontWeight: FontWeight.bold);

  Future<void> chageController() async {
    if (_loginInput != "" && _passwordInput != "") {
      await logIn(_loginInput, _passwordInput).then((_) {
        print("PassControler is $passController");
        if (passController) {
          first_time = true;
          user_list = {};
          _loginInput = "";
          _passwordInput = "";
          passController = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => App()));
        }
      });
    }
  }

  void goToReg() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => Registry()));
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
          filled: true,
          fillColor: Colors.white,
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
          filled: true,
          fillColor: Colors.white,
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );

    final _enterButton = Column(children: <Widget>[
      SizedBox(
        height: 10,
      ),
      Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff3498DB),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            print("Button pressed!");
            chageController();
          },
          child: Text("Войти",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    ]);

    final _registry = Column(children: <Widget>[
      SizedBox(
        height: 10,
      ),
      Container(
        margin: EdgeInsets.only(bottom: 200),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff3498DB),
          child: Container(
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                print("Switched to registry");
                goToReg();
              },
              child: Text("Регистрация",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    ]);

    return Scaffold(
      backgroundColor: Color(0xff22313F),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 30),
            Column(children: <Widget>[
              Container(color: Colors.white),
              loginField,
              SizedBox(height: 30),
              passwordField
            ]),
            _enterButton,
            _registry,
          ],
        ),
      )),
    );
  }
}
