import 'package:flutter/material.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

late Database _database;

Future<void> setupSembast() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = '${appDir.path}/app_database.db';
  _database = await databaseFactoryIo.openDatabase(dbPath);
}

Database get database => _database;
