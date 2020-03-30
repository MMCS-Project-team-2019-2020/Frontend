import 'package:flutter/material.dart';
import './Authorization/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      theme: ThemeData(primaryColor: Colors.purple),
      home: LoginScreen(),
    );
  }
}
