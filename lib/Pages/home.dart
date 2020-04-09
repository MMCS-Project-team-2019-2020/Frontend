import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/Helpers/enter.dart';
import 'package:shared/Helpers/cards.dart';
import 'profile.dart';
import 'account.dart';

String card_result = "";
String ownerID;
String cardID;
bool _isCard = false;

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  String scan_card = "";
  bool ohWait = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Color(0xff22313F),
        appBar: new AppBar(
          backgroundColor: Colors.white,        
          title: new Text('Сканер', style: TextStyle(color: Colors.black),), 
        ),
        body: new Center(  
            child: ohWait
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Идёт обработка данных..."),
                      CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  )
                : new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: !_isCard
                        ? [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: RaisedButton(
                                  color: Color(0xffDFDFDF),
                                  textColor: Colors.black,
                                  splashColor: Colors.blueGrey,
                                  onPressed: scan,
                                  child: const Text('Сканировать')),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                barcode,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]
                        : [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                card_result,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: RaisedButton(
                                  color: Color(0xffDFDFDF),
                                  textColor: Colors.black,
                                  splashColor: Colors.blueGrey,
                                  onPressed: Accept,
                                  child: const Text('Принять')),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: RaisedButton(
                                  color: Color(0xffDFDFDF),
                                  textColor: Colors.black,
                                  splashColor: Colors.blueGrey,
                                  onPressed: () => setState(() {
                                        _isCard = false;
                                        card_result = "error";
                                      }),
                                  child: const Text("Отменить")),
                            ),
                          ])));
  }

  Future<void> Accept() async {
    try {
      print("Accepting...");
      print(ownerID);
      await getCardToUser(ownerID, cardID, main_user).then((_) {
        inProcess = true;
        print("Filling...");
        user_list = [];
        setState(() {
          _isCard = false;
          barcode = "";
        });
        filling(main_user)
            .then((_) => fillList(user_list).then((_) => inProcess = false));
      });
    } catch (e) {
      print(e);
      setState(() {
        _isCard = false;
        barcode =
            "Невозможно добавить эту визитку. \nВозможно, она у вас уже есть.";
      });
    }
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print("barcode is $barcode");
      getCard(barcode).then((_) {
        if (card_result != "error" && card_result != "") {
          _isCard = true;
          ohWait = false;
          setState(() {});
        }
      });
      ohWait = true;
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)',);
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
