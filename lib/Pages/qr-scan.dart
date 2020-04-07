import '../Authorization/enter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import './profile.dart';

String result = "";
Future<void> scanQR() async {
  try {
    await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.QR)
        .then((result) {
      var _ids = result.split(' ');
      String _owner_id = _ids[0];
      String _card_id = _ids[1];
      if (!main_user.own_cards.contains(_card_id)) {
        getCard(_owner_id, _card_id, main_user).then((_) {
          getProfile(
              main_user.id, main_user); //  Обновление данных пользователя
        });
      }
    });
  } catch (exception) {
    print(exception.toString());
  }
}
