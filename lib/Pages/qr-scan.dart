import '../Authorization/enter.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import './profile.dart';

String result = "";
Future _scanQR() async {
  try {
    String barcode = await BarcodeScanner.scan();
    var result = barcode.split(" ");
    String _owner_id = result[0];
    String _card_id = result[0];
    if (!main_user.own_cards.contains(_card_id)) {
      getCard(_owner_id, _card_id, main_user).then((_) {
        getProfile(main_user.id, main_user); //  Обновление данных пользователя
      });
    }
    ;
  } catch (e) {
    print(e.toString());
  }
}
