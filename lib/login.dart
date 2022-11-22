import 'package:flutter/material.dart';
import 'package:test_app/Alert_HelpUser.dart';
import 'package:test_app/Data_user.dart';
import 'package:test_app/Home.dart';
import 'package:test_app/database.dart';

import 'package:test_app/my_style.dart';
import 'package:test_app/register.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);
  @override
  loginState createState() => loginState();
}

class loginState extends State<login> {
  late double screen;

  TextEditingController username = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool _isObscure = true;
  //สร้างตัวแปร fromKey
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
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
                        'Login',
                        style: TextStyle(
                          fontSize: 50,
                          color: MyStyle().blackColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rajdhani',
                        ),
                      ),
                      username_(),
                      Passwordd(),
                      NextToHome(),
                      Register_(),
                    ],
                  ),
                ))));
  }

  Container username_() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: username,
        decoration: InputDecoration(
            labelText: 'Username',
            suffixIcon: IconButton(
              onPressed: () {
                username.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            prefixIcon: Icon(Icons.account_box_sharp),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value!.isEmpty) {
            return "กรุณากรอก Username";
          } else if (value.length < 3) {
            return "ชื่อผู้ใช้จะต้องมีความยาว 6 ตัวอักษรขึ้นไป";
          } else if (value.length > 30) {
            return "ชื่อผู้ใช้จะต้องมีความยาวไม่เกิน 25 ตัวอักษ";
          } else
            return null;
        },
      ),
    );
  }

  Container Passwordd() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: Password,
        //maxLength: 25, จำกัด 25 ตัว
        obscureText: _isObscure,
        decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.password),
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            // enabledBorder:
            //   Out4lineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          final passwordRegex = RegExp('[^A-Za-z0-9_]');
          if (value!.isEmpty) {
            return "กรุณากรอกรหัสผ่าน";
          }
          if (value.length < 6) {
            return "รหัสผ่านจะต้องมีความยาว 6 ตัวอักษรขึ้นไป";
          }
          if (value.length > 25) {
            return "รหัสผ่านจะต้องมีความยาวไม่เกิน 25 ตัวอักษร";
          } else
            return null;
        },
      ),
    );
  }

  Container NextToHome() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        onPressed: () async {
          DB db = DB();
          WidgetsFlutterBinding.ensureInitialized();
          bool validate = _fromKey.currentState!.validate();

          if (validate) {
            var Data_user_login = (await db.get_User_for_login(username.text));
            if (Data_user_login.length != 0 &&
                Data_user_login[0]['Password'] == Password.text) {
              data_user data_U = new data_user();
              var user_db =
                  (await db.get_username(Data_user_login[0]['id']))[0];
              print(user_db);
              data_U.setdatauer_from_db(user_db);
              print(data_U.getdatauser());
              // var Datuser = data_U.setdatauer_from_db(
              // (await db.get_username(Data_user_login['id']))[0]);

              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('ยินดีตอนรับคุณ ' +
                      data_U.Firstname +
                      " " +
                      data_U.Lastname),
                ),
              );
              Password.clear();
              username.clear();

              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Home_(
                        dataUser: data_U,
                      ));
              Navigator.of(this.context).push(materialPageRoute);
            } else {
              AlertDialogs_help_user.help_Dialog(
                  context,
                  'ไม่พบข้อมูลผู้ใช้ในระบบ',
                  'กรุณา สมัครสมาชิก หรือ ติดต่อผู้ดูแลระบบ');
            }
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().perpleColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Container Register_() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Text(
              'สมัครสมาชิก',
              style: TextStyle(
                color: MyStyle().perpleColor,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            onPressed: () {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => Register());
              Navigator.of(this.context).push(materialPageRoute);
            },
          )
        ],
      ),
    );
  }
}
