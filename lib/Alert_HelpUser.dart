// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:test_app/login.dart';
import 'package:test_app/register.dart';
import 'package:url_launcher/url_launcher.dart';

enum DialogsAction { Tel, Register }

class AlertDialogs_help_user {
  static Future<DialogsAction> help_Dialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            //ShowImage(name: title, selectbum: selectbum)
                            Register()));
              },
              child: Text(
                'Register',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              //onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
              onPressed: () async {
                //var tel = "1176";
                launch('tel://1176');
                //await FlutterPhoneDirectCaller.callNumber("1176");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            //ShowImage(name: title, selectbum: selectbum)
                            login()));
              },
              child: Text(
                'ติดต่อผู้ดูแลระบบ',
                style: TextStyle(
                    color: Color.fromARGB(255, 36, 9, 15),
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.values;
  }
}
