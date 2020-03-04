import 'package:flutter/material.dart';
import './transaction.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: "id1", 
      title: "SomeTitle1", 
      amount: 69.99, 
      date: DateTime.now()
      ),
    Transaction(
      id: "id2", 
      title: "ElDora", 
      amount: 01.99, 
      date: DateTime.now()
    ),
    Transaction(
      id: "id3", 
      title: "Some wear", 
      amount: 432.22, 
      date: DateTime.now()
      )
  ];

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
            child: 
            Column(children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal:30, vertical: 20),
                      child: Text('\$' + tx.amount.toString()),
                      decoration: BoxDecoration(
                         border: Border.all(
                          color: Colors.black, width:2,
                        )
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                    Column(
                      children: <Widget>[
                        Text(tx.title),
                        Text(tx.date.toString())
                      ],
                    )
                  ],
                )
              );
            }).toList()
            ),
            )
      ],));
  }
}
