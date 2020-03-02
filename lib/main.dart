import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App#2',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Playground"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: double.infinity,
            child: Card(color: Colors.purple, 
              child: Text("Chart"),
            elevation: 10,),
          ),
          Container(
            width: 100,
            child: Card(color: Colors.purple, 
              child: Text("List of Transactions", textAlign: TextAlign.center,)
            ),
          ),
      ],));
  }
}
