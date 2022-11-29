import 'dart:io';

import 'package:path/path.dart';
import 'package:side_menu/family_list.dart';
import 'package:side_menu/modelClasses/family_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "MedicineTracker.db";
  static final _databaseVersion = 1;

  static final table = 'FamilyList';
  static final table2 = 'Symptoms';
  static final table3 = "Medicines";
  static final name = 'name';
  static final age = 'age';
  static final gender = 'gender';
  static final mobileNumber = 'mobile number';
  static final id = 'id';
  static final password = 'password';
  static final mpin = 'mpin';
  // static final tableContact = 'contact';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database?> get database1 async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  insertProduct() {}

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print("document path ${documentsDirectory.path}");
    //saikrish/desktop/app/
    String path = join(documentsDirectory.path, _databaseName);
    //saikrish/desktop/app/cgg.db
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE FamilyList
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name varchar(255),
age varchar(255),
gender varchar(255),
mobileNumber varchar(255),
mpin varchar(255)
);
          ''');
    await db.execute('''CREATE TABLE Symptoms(
      SymptomId INTEGER PRIMARY KEY AUTOINCREMENT,
      mobileNumber varchar(255),
      FamilyMemberName varchar(255),
      Symptom varchar(255),
      MedicineName varchar(255),
      DoctorName varchar(255),
      HospitalName varchar(255),
      DateOfAppointment varchar(255),
      ReasonForAppointment varchar(255)
          );
                    ''');
    await db.execute('''
          CREATE TABLE Medicines
(
MedicineId INTEGER PRIMARY KEY AUTOINCREMENT,
MedicineName varchar(255),
ExpiryDate varchar(255),
MedicinePhoto varchar(255),
SymptomId varchar(255)
);
          ''');
    // await db.execute(
    //     "CREATE TABLE user (username TEXT NOT NULL,phone TEXT NOT NULL,email TEXT NOT NULL)");
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(
    Map<String, dynamic> row,
  ) async {
    Database? db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> insertInto(Map<String, dynamic> row, String tableName) async {
    Database? db = await instance.database;
    return await db.insert(tableName, row);
  }
  // Future<int> insertContact(Map<String, dynamic> row) async {
  //   Database? db = await instance.database;
  //   return await db.insert(tableContact, row);
  // }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Future<List<Map<String, dynamic>>> queryAllRowsofContact() async {
  //   Database db = await instance.database;
  //   return await db.query(tableContact);
  // }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $table')) ??
        0;
  }

  //Used for getting the last row count or last symptom Id added
  Future<int> queryRowLast(String tablename) async {
    Database db = await instance.database;

    if (tablename == table) {
      return Sqflite.firstIntValue(await db.rawQuery(
              'SELECT SymptomId FROM $table ORDER BY SymptomId DESC LIMIT 1')) ??
          0;
    } else if (tablename == table2) {
      return Sqflite.firstIntValue(await db.rawQuery(
              'SELECT SymptomId FROM $table2 ORDER BY SymptomId DESC LIMIT 1')) ??
          0;
    } else {
      return Sqflite.firstIntValue(await db.rawQuery(
              'SELECT SymptomId FROM $table2 ORDER BY SymptomId DESC LIMIT 1')) ??
          0;
    }
  }

  // Future<String> queryLogin(String username, String pwd, String table) async {
  //   Database db = await instance.database;
  //   return await db
  //           .rawQuery('SELECT * FROM $table) ??
  //       "";

  // }
  Future<List<Map>> queryLogin(String table) async {
    Database? db = await instance.database;
    List<Map> list = await db.rawQuery('SELECT * FROM $table');
    return list;
  }

  // List<Map> expectedList = [
  //   {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
  //   {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
  // ];
  // print(list);
  // print(expectedList);
  // // We are assuming here that the id column in the map is set. The other
  // // column values will be used to update the row.
  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   String id = row[columnId];
  //   return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  // }

  // // Deletes the row specified by the id. The number of affected rows is
  // // returned. This should be 1 as long as the row exists.
  Future<int> delete(String name) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$name = ?', whereArgs: [name]);
  }

  /*  Future<User> checkLogin(String userName, String password) async {
    final dbClient = await db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM $USER_TABLE WHERE username = '$userName' and password = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  } */

  /* Future<familyListModel> checkLogin(familyListModel mobileNumber) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT * FROM $table WHERE mobileNumber = '$mobileNumber'");

    if (res.length > 0) {
      return new familyListModel.fromMap(res.first);
    }
    return null;
  } */
  // Future<int> deleteContact(int id) async {
  //   Database db = await instance.database;
  //   return await db
  //       .delete(tableContact, where: '$columnId = ?', whereArgs: [id]);
  // }
  //CRUD
  //Creation
  //Read
  //Update
  //Delete
}
