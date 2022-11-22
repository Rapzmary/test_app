import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  //
  static Database? _db;
  static const String User_for_login = 'User_for_loginTable';
  static const String User_ = 'UserTable';
  static const String DB_NAME = 'database.db';

  Future<Database?> get db async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final db = openDatabase(
      join(documentsDirectory.path, DB_NAME),
    );
  }

  delete_database() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File filedatabase = await new File(join(documentsDirectory.path, DB_NAME));
    bool checkfile = await filedatabase.existsSync();
    File filedatabaseJ =
        await new File(join(documentsDirectory.path, "database.db-journal"));
    if (checkfile) {
      /*final db2 = await openDatabase(
        join(documentsDirectory.path, DB_NAME),
      );*/
      filedatabaseJ.delete();
      filedatabase.delete();

      //เขียนลบ database
    }
    print(await openDatabase(
      join(documentsDirectory.path, DB_NAME),
    ));
    print('db ลบแล้วววววววววววววววววว');
  }

  checkDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File filedatabase = await new File(join(documentsDirectory.path, DB_NAME));
    bool checkfile = await filedatabase.existsSync();

    if (checkfile) {
      final db2 = await openDatabase(
        join(documentsDirectory.path, DB_NAME),
      );
      print(await db2.runtimeType);
      _db = await db2;
      print('db ไม่ว่างงงงงงงง');
      return await _db;

      //เขียนลบ database
    }

    _db = await initDB();
    print('db ว่างงงงงงงง');
    return await _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db2 = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db2;
  }

  _onCreate(Database db, int version) async {
    String id = "id";
    String Username = 'Username';
    String Password = 'Password';
    String Firstname = 'Firstname';
    String Lastname = 'Lastname';
    String ID_card = 'ID_card';
    String Phonenumber = 'Phonenumber';
    String Address_image = 'Address_image';

    await db.execute(
        'CREATE TABLE $User_for_login ($Username TEXT PRIMARY KEY ,$Password TEXT , $id TEXT )');
    await db.execute(
        'CREATE TABLE $User_ ($id TEXT PRIMARY KEY ,$Username TEXT , $Password TEXT ,$Firstname TEXT ,$Lastname TEXT,$ID_card TEXT ,$Phonenumber TEXT ,$Address_image TEXT)');
  }

  save_user(var user) async {
    var dbClient = await checkDatabase();
    await dbClient.insert(User_, user,
        conflictAlgorithm: ConflictAlgorithm.replace);

    var User_for_login_ = {
      "Username": user['Username'],
      "Password": user['Password'],
      "id": user['id']
    };
    await dbClient.insert(User_for_login, User_for_login_,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deletedata_intable() async {
    var dbClient = await checkDatabase();
    await dbClient.delete(
      User_for_login,
    );
    await dbClient.delete(
      User_,
    );
  }

  getdatauser_() async {
    var dbClient = await checkDatabase();

    return (await dbClient.query(User_));
  }

  getdata_User_for_login() async {
    var dbClient = await checkDatabase();

    return (await dbClient.query(User_for_login));
  }

  get_User_for_login(var username) async {
    var dbClient = await checkDatabase();

    return (await dbClient
        .query(User_for_login, where: '"Username" = ?', whereArgs: [username]));
  }

  get_username(var id) async {
    var dbClient = await checkDatabase();
    //var name = "'" + '"' + "photoclass" + '"' + ' = ' + namealbum + "'";
    print("dddddd");
    return (await dbClient.query(User_, where: '"id" = ?', whereArgs: [id]));
  }
}
