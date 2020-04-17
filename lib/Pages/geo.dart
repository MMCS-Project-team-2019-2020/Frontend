import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class ListenPage extends StatefulWidget {
  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  Geolocator geolocator = Geolocator();
  List<Placemark> userLocation;

  Future<List<Placemark>> getLocation() async {
    var currentLocation;
    List<Placemark> placemark;
    try {
      print("there");
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      placemark = await geolocator.placemarkFromPosition(currentLocation);
    } catch (e) {
      print(e);
      currentLocation = null;
    }
    return placemark;
  }

  //TODO: Заебашить "Город, улица, дом" к создаваемой визитке на экране scan... Или в enter, хуй его знает

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation().then((placemark) {
      userLocation = placemark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("User location is :\n " +
                    '\nName: ' +
                    userLocation[0].name +
                    '\nCountry: ' +
                    userLocation[0].country +
                    '\nAA: ' +
                    userLocation[0].administrativeArea +
                    '\nLocality: ' +
                    userLocation[0].locality +
                    '\nSAA: ' +
                    userLocation[0].subAdministrativeArea +
                    '\nSubLocality: ' +
                    userLocation[0].subLocality +
                    '\nTF: ' +
                    userLocation[0].thoroughfare +
                    '\nSTF: ' +
                    userLocation[0].subThoroughfare),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  getLocation().then((value) {
                    setState(() {
                      print(value);
                      userLocation = value;
                    });
                  });
                },
                color: Colors.blue,
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
