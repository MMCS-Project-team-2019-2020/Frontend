import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import '../Authorization/enter.dart';
import './profile.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContent createState() => _HomeContent();
}

class _HomeContent extends State<HomeContent> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: RaisedButton(
                onPressed: () => scanQR(),
                child: Text(
                  "Сканировать QR",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.green,
              ),
              padding: const EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }

  //scan barcode asynchronously
  String result = "";
  Future scanQR() async {
    try {
      String barcode = await BarcodeScanner.scan();
      var result = barcode.split(" ");
      String _owner_id = result[0];
      String _card_id = result[0];
      if (!main_user.own_cards.contains(_card_id)) {
        getCard(_owner_id, _card_id, main_user).then((_) {
          getProfile(
              main_user.id, main_user); //  Обновление данных пользователя
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
