import 'package:flutter/material.dart';
import 'package:test_app/Data_user.dart';
import 'package:test_app/Home.dart';

import 'package:test_app/my_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_location extends StatefulWidget {
  data_user dataUser;
  Map_location({required this.dataUser});

  @override
  Map_location_state createState() =>
      new Map_location_state(dataUser: dataUser);
}

class Map_location_state extends State<Map_location> {
  data_user dataUser;
  Map_location_state({required this.dataUser});
  late double screen;
  late GoogleMapController mapController;
  void _onmapcreate(GoogleMapController controller) {
    mapController = controller;
  }

  late Position My_location;

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    My_location = await Geolocator.getCurrentPosition();
    return My_location;
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("My location",
            style: TextStyle(
              color: MyStyle().whiteColor,
            )),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().whiteColor,
            ),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home_(dataUser: dataUser)));
            }),
        backgroundColor: MyStyle().blackColor,
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onmapcreate,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(My_location.latitude, My_location.longitude),
                  zoom: 20),
            );
          } else {
            return Center(
              child: Column(children: <Widget>[
                CircularProgressIndicator(),
              ]),
            );
          }
        },
      ),
    );
  }
}
