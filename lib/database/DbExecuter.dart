import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/models/ExpenseModel.dart';

class DbExecuter {
  var expensesDB = "expenses.db";
  var expenses = "expenses";
  var expenseId = "expenseId";
  var expenseDateCreated = "expenseDateCreated";
  var expenseCat = "expenseCat";
  var expenseName = "expenseName";
  var expenseFrequency = "expenseFrequency";
  var expenseAmount = "expenseAmount";

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, expensesDB),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE expenses($expenseId INTEGER PRIMARY KEY AUTOINCREMENT, $expenseDateCreated TEXT NOT NULL,$expenseName TEXT NOT NULL,  $expenseAmount TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertProducts(List<ExpenseModel> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert(expenses, user.toMap());
    }
    return result;
  }

  Future<int> insertProduct(ExpenseModel product) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert(expenses, product.toMap());
    return result;
  }

  Future<List<ExpenseModel>> retrieveExpenses() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(expenses);
    return queryResult.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      expenses,
      where: "$expenseId = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(ExpenseModel product) async {
    final database = await initializeDB();
    return await database.update(expenses, product.toMap(),
        where: "$expenseId = ?", whereArgs: [product.expenseId]);
  }
}
