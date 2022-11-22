//import 'dart:html';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/Data_user.dart';
import 'package:test_app/database.dart';
import 'package:test_app/login.dart';
import 'package:test_app/my_style.dart';
//import 'package:project_photo_learn/main.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  late double screen;
  TextEditingController userName = TextEditingController();
  TextEditingController PasswordRe = TextEditingController();
  TextEditingController FirstNameRe = TextEditingController();
  TextEditingController LastNameRe = TextEditingController();
  TextEditingController ID_card = TextEditingController();
  TextEditingController Phonenumber = TextEditingController();

  //สร้างตัวแปร fromKey
  final _fromKey = GlobalKey<FormState>();

  bool _isObscure = true;

  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              MaterialPageRoute materialPageRoute =
                  MaterialPageRoute(builder: (BuildContext context) => login());
              Navigator.of(this.context).push(materialPageRoute);
            },
          ),
          backgroundColor: MyStyle().blackColor,
        ),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Form(
                      key: _fromKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              //fontStyle: FontStyle.normal,
                              fontFamily: 'Rajdhani',
                            ),
                          ),
                          userName_Input(),
                          PassWord_Input(),
                          FirstName_Input(),
                          LastName_Input(),
                          ID_card_Input(),
                          Phonenumber_Input(),
                          selectimage(),
                          _image != null
                              ? Image.file(
                                  _image!,
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://pngfreely.com/wp-content/uploads/2021/09/%E0%B8%84%E0%B8%99-Png-Avatar-Icon-Profile-Icon-Member-Login-%E0%B9%84%E0%B8%AD%E0%B8%84%E0%B8%AD%E0%B8%99%E0%B9%82%E0%B8%9B%E0%B8%A3%E0%B9%84%E0%B8%9F%E0%B8%A5%E0%B9%8C.png"),
                          Confirm_register(),
                        ],
                      ),
                    )))));
  }

  var nameimage = "เลือกรูปภาพ";
  var image;
  File? _image = null;
  _getFromGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    //nameimage = image.name;

    final ImageTemp = File(image.path);
    setState(() {
      this._image = ImageTemp;
    });
  }

  Container selectimage() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        onPressed: () => {_getFromGallery()},
        child: Row(
          children: [
            Icon(Icons.image_outlined),
            SizedBox(
              width: 20,
            ),
            Text(nameimage)
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().perpleColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Future<File> saveFilePermanently(var file) async {
    final appStorage = await getApplicationSupportDirectory();
    // final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    print('saveFilePermanently :');
    print(appStorage.path);
    print('saveFilePermanently Name :');
    print(file.name);
    return File(file.path!).copy(newFile.path);
  }

  Container Confirm_register() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        child: Text('register'),
        onPressed: () async {
          DB db = DB();

          WidgetsFlutterBinding.ensureInitialized();
          bool validate = _fromKey.currentState!.validate();
          if (_image == null) {
            await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('กรุณาใส่รูปภาพ'),
              ),
            );
          }
          if (validate && _image != null) {
            if ((await db.get_username(userName.text)).length != 0) {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('๊Username มีในระบบแล้ว'),
                ),
              );
            } else {
              data_user dataU = new data_user();
              var imagefile = await saveFilePermanently(image);
              dataU.setdatauser(
                  userName.text,
                  PasswordRe.text,
                  FirstNameRe.text,
                  LastNameRe.text,
                  ID_card.text,
                  Phonenumber.text,
                  imagefile.path);
              await db.save_user(dataU.get_Mapdata_user());
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('สมัครสมาชิกสำเร็จ'),
                ),
              );
              userName.clear();
              PasswordRe.clear();
              FirstNameRe.clear();
              LastNameRe.clear();
              ID_card.clear();
              Phonenumber.clear();
              MaterialPageRoute materialPageRoute =
                  MaterialPageRoute(builder: (BuildContext context) => login());
              Navigator.of(this.context).push(materialPageRoute);
            }
          }
        },
        style: ElevatedButton.styleFrom(
            primary: MyStyle().perpleColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Container userName_Input() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: userName,
        //maxLength: 30, //รับไม่เกิน 30 ตัว
        decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: Icon(Icons.account_box_sharp),
            suffixIcon: IconButton(
              onPressed: () {
                userName.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          print("Username");
          print(value);
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

  Container PassWord_Input() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: PasswordRe,
        //maxLength: 25,
        obscureText: _isObscure,
        decoration: InputDecoration(
            hintText: ("Password"),
            labelText: ('Password'),
            //labelText: ('should be more than 6 charecters.'),
            prefixIcon: Icon(Icons.password),
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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

  Container FirstName_Input() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: FirstNameRe,
        //maxLength: 30, //รับไม่เกิน 30 ตัว
        decoration: InputDecoration(
            labelText: 'ชื่อ',
            prefixIcon: Icon(Icons.perm_identity),
            suffixIcon: IconButton(
              onPressed: () {
                FirstNameRe.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value!.isEmpty) {
            return "กรุณากรอกชื่อ";
          } else if (value.length < 3) {
            return "ชื่อจะต้องมีความยาว 3 ตัวอักษรขึ้นไป";
          } else if (value.length > 30) {
            return "ชื่อจะต้องมีความยาวไม่เกิน 30 ตัวอักษร";
          } else
            return null;
        },
      ),
    );
  }

  Container LastName_Input() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: LastNameRe,
        //maxLength: 30,
        decoration: InputDecoration(
            labelText: 'นามสกุล',
            prefixIcon: Icon(Icons.perm_identity),
            suffixIcon: IconButton(
              onPressed: () {
                LastNameRe.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value!.isEmpty) {
            return "กรุณากรอกนามสกุล";
          } else if (value.length < 3) {
            return "นามสกุลจะต้องมีความยาว 3 ตัวอักษรขึ้นไป";
          } else if (value.length > 30) {
            return "นามสกุลจะต้องมีความยาวไม่เกิน 30 ตัวอักษร";
          } else
            return null;
        },
      ),
    );
  }

  Container ID_card_Input() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: ID_card,
        decoration: InputDecoration(
            labelText: 'เลขบัตรประชาชน',
            prefixIcon: Icon(Icons.badge),
            suffixIcon: IconButton(
              onPressed: () {
                ID_card.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          if (value!.isEmpty) {
            return "กรุณากรอกเลขบัตรประชาชน 13 หลัก";
          } else if (value.length != 13) {
            return "กรุณากรอกเลขบัตรประชาชน 13 หลักให้ถูกต้อง";
          } else
            return null;
        },
      ),
    );
  }

  Container Phonenumber_Input() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
          controller: Phonenumber,
          decoration: InputDecoration(
              labelText: 'เบอร์โทรศัพท์',
              prefixIcon: Icon(Icons.add_ic_call_outlined),
              suffixIcon: IconButton(
                onPressed: () {
                  Phonenumber.clear();
                },
                icon: const Icon(Icons.clear),
              ),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          validator: (value) {
            if (value!.isEmpty) {
              return "กรุณากรอกเบอร์โทรศัพท์ 10 หลัก";
            } else if (value.length != 10) {
              return "กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง";
            } else
              return null;
          }),
    );
  }
}
