import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      theme: ThemeData(primaryColor: Colors.purple),
      home: MyHomePage(title: "Login"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(
      color: Colors.deepPurple[100], fontFamily: 'Montserrat', fontSize: 15);

  @override
  Widget build(BuildContext context) {
    final login_field = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          hintText: 'Login',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );
    final password_field = TextField(
      obscureText: true, //Hiding an input text
      style: style,
      decoration: InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );

    final enter_button = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.blueGrey[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {}, //TODO: request
        child: Text("Logiin",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.blueGrey, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      body: Center(
          child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            login_field,
            SizedBox(height: 30),
            password_field,
            SizedBox(height: 30),
            enter_button,
          ],
        ),
      )),
    );
  }
}
