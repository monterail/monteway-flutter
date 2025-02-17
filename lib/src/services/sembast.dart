import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast_web/sembast_web.dart';

const String _databaseName = 'app_database.db';
late Database _database;

Future<void> setupSembast() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // Web-specific database initialization
    _database = await databaseFactoryWeb.openDatabase(_databaseName);
  } else {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDir.path}/$_databaseName';
    _database = await databaseFactoryIo.openDatabase(dbPath);
  }
}

Database get database => _database;
