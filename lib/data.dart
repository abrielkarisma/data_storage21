import 'dart:convert';
import 'dart:io';
import 'package:data_storage21/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataS extends StatefulWidget {
  const DataS({super.key});

  @override
  State<DataS> createState() => _DataSState();
}

class _DataSState extends State<DataS> {
  String nama = 'Abriel Karisma';
  String SavedName = '';
  String token = '759ngfdnndkmg59u5u98u584';
  String SavedToken = '';
  User? LocalUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Storage'),
        ),
        body: Center(
          child: Column(children: [
            ElevatedButton(
                onPressed: () {
                  SaveNama();
                },
                child: Text("Simpan")),
            ElevatedButton(
                onPressed: () {
                  AmbilData();
                },
                child: Text("Ambil")),
            Text(
              SavedName.isNotEmpty ? "User: $SavedName" : "User : Gak ada data",
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  SaveToken();
                },
                child: Text("Simpan Token")),
            ElevatedButton(
                onPressed: () {
                  AmbilToken();
                },
                child: Text("Ambil Token")),
            Text(
              SavedToken.isNotEmpty ? "Token: $SavedToken" : "Token: No data",
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  SimpanLocal();
                },
                child: Text("Simpan Local")),
            ElevatedButton(
                onPressed: () {
                  AmbilLocal();
                },
                child: Text("Ambil Local")),
            Text(
              LocalUser != null
                  ? "User: ${LocalUser!.name}, Token: ${LocalUser!.token}"
                  : "User: No data",
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  BuatTabel();
                },
                child: Text("Buat Tabel")),
          ]),
        ));
  }

  void SaveNama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('User', "kontol");
  }

  void AmbilData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      SavedName = prefs.getString('User')!;
    });
  }

  void SaveToken() async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'UserToken', value: token);
  }

  void AmbilToken() async {
    final storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'UserToken');
    setState(() {
      SavedToken = value ?? 'No data';
    });
  }

  Future<void> SimpanLocal() async {
    final filename = "local_user";
    final file = File(
        '${(await getApplicationDocumentsDirectory()).path}/$filename.json');
    User user = User(name: nama, token: token);
    await file.writeAsString(json.encode(user.toJson()));
  }

  Future<void> AmbilLocal() async {
    final filename = "local_user";
    final file = File(
        '${(await getApplicationDocumentsDirectory()).path}/$filename.json');
    String fileContent = await file.readAsString();
    setState(() {
      LocalUser = User.fromJson(json.decode(fileContent));
    });
  }

  Future<void> BuatTabel() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
  }
}
