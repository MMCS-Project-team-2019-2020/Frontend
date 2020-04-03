import 'package:flutter/material.dart';
import '../Authorization/enter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import './profile.dart';

String result = "";
Future<void> scanQR() async {
  await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR)
      .then((result) {
    String _owner_id = result.split(' ')[0];
    String _card_id = result.split(' ')[1];
    if (!main_user.own_cards.contains(_card_id)) {
      try {
        getCard(_owner_id, _card_id, main_user).then((_) {
          getProfile(
              main_user.id, main_user); //  Обновление данных пользователя
          //TODO: Прихуярить навигатор, пожалуйста.
        });
      } catch (CardException) {
        //Вывести "Не повезло, не фартануло"
      }
    }
  });
}
