import 'package:flutter/material.dart';
import 'package:test_app/database.dart';
import 'package:test_app/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DB database = await new DB();
  await database.checkDatabase();
  print(await database.getdatauser_());
  print(await database.getdata_User_for_login());
  // await database.deletedata_intable();
  runApp(test_App());
}

class test_App extends StatefulWidget {
  test_App();
  @override
  State<test_App> createState() => test_AppState();
}

class test_AppState extends State<test_App> {
  test_AppState();
  get home => null;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login(),
    );
  }
}
