import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test_app/Data_user.dart';
import 'package:test_app/Map_location.dart';
import 'package:test_app/my_style.dart';

class Home_ extends StatefulWidget {
  data_user dataUser;
  Home_({required this.dataUser});

  @override
  _HomeState createState() => new _HomeState(dataUser: dataUser);
}

class _HomeState extends State<Home_> {
  data_user dataUser;
  _HomeState({required this.dataUser});
  late double screen;
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("ข้อมูลผู้ใช้ ",
              style: TextStyle(
                color: MyStyle().whiteColor,
              )),
          backgroundColor: MyStyle().blackColor,
        ),
        body: SingleChildScrollView(
            //alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Form(
                  key: _fromKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dataUser.getdatauser(),
                        style: TextStyle(
                          fontSize: 20,
                          color: MyStyle().blackColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rajdhani',
                        ),
                      ),
                      /*Ink.image(
                        fit: BoxFit.cover,
                        image: FileImage(File(dataUser.Address_image)),
                        //image: AssetImage(img),
                        child: InkWell(),
                      ),*/
                      Image.file(
                        File(dataUser.Address_image),
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Map_location_(),
                    ],
                  ),
                ))));
  }

  Container Map_location_() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Text(
              'My location',
              style: TextStyle(
                color: MyStyle().perpleColor,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            onPressed: () {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Map_location(dataUser: dataUser));
              Navigator.of(this.context).push(materialPageRoute);
            },
          )
        ],
      ),
    );
  }
}
