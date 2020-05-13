import 'package:geolocator/geolocator.dart';
import 'package:mobyte_mmcs_cards/Helpers/requests.dart';
import 'package:mobyte_mmcs_cards/Helpers/user.dart';
import 'package:barcode_scan/barcode_scan.dart';

Requests _req = Requests();
Geolocator geolocator = Geolocator();

///Возвращает лист, где 0 элемент - данные геопозиции, а 1 - ID карты
Future<String> scan() async {
  var cameraScanResult = await BarcodeScanner.scan(); //Сканирование
  return cameraScanResult.rawContent;
}

Future<String> getLocation() async {
  var currentLocation;
  List<Placemark> placemark;
  try {
    if (await geolocator.isLocationServiceEnabled()) {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      placemark = await geolocator.placemarkFromPosition(currentLocation);
    } else
      return "Не удалось получить данные.";
  } catch (exception) {
    return "Не удалось получить данные.";
  }
  return placemark[0].subAdministrativeArea +
      " " +
      placemark[0].thoroughfare +
      " " +
      placemark[0].name;
}

Future<bool> accept(
    User user, String location, Map<String, String> card) async {
  return await _req.getCardToUser(
      ownerID: card['ownerID'],
      cardID: card['cardID'],
      geo: location,
      user: user);
}
