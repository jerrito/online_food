import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Data {
    Future<Database> databases() async {
        final database = openDatabase(
            join(await getDatabasesPath(), 'pashewCart.db'),
            version: 1,);
//final db = await database;
        return database;
    }
}