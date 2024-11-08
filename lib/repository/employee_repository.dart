import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/repository/database_helper.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeRepository {
  static final sharedInstance = EmployeeRepository._();

  EmployeeRepository._();

  Future<int> insertEmployee(Employee employee) async {
    Database db = await DatabaseHelper.sharedInstance.database;
    return await db.insert(DatabaseHelper.table, employee.toMap());
  }

  Future<List<Employee>> getCurrentEmployees() async {
    Database db = await DatabaseHelper.sharedInstance.database;
    final List<Map<String, dynamic>> maps = await db.query(DatabaseHelper.table,
        where: 'toDate = ?', whereArgs: [noDateHintText]);
    return List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
  }

  Future<List<Employee>> getPreviousEmployees() async {
    Database db = await DatabaseHelper.sharedInstance.database;
    final List<Map<String, dynamic>> maps = await db.query(DatabaseHelper.table,
        where: 'toDate != ?', whereArgs: [noDateHintText]);
    return List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
  }

  Future<void> updateEmployee(Employee employee) async {
    Database db = await DatabaseHelper.sharedInstance.database;
    await db.update(
      DatabaseHelper.table,
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<void> deleteEmployee(int id) async {
    Database db = await DatabaseHelper.sharedInstance.database;
    await db.delete(
      DatabaseHelper.table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
