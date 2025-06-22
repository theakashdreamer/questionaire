import 'package:questionaire/mvvm_implementation/core/constants/logger.dart' show AppLogger;
import 'package:questionaire/mvvm_implementation/core/database/db_constants.dart' show DBConstants;
import 'package:questionaire/mvvm_implementation/core/database/db_service.dart' show DBService;
import '../model/user_model.dart';

class UserDAO {
  final DBService _db = DBService();

  Future<int> registerUser(UserModel user) async {
    return await _db.insert(DBConstants.userTable, user.toMap());
  }
  Future<void> printAllUsers() async {
    final result = await _db.select(table: DBConstants.userTable);
    if (result.isEmpty) {
      AppLogger.i("📭 No users found.");
    } else {
      for (final row in result) {
        AppLogger.d("📦 User → ID: ${row['id']}, Email: ${row['email']}, Password: ${row['password']}");
      }
    }
  }


  Future<UserModel?> loginUser(String email, String password) async {
    final result = await _db.select(
      table: DBConstants.userTable,
      where: '${DBConstants.columnEmail} = ? AND ${DBConstants.columnPassword} = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final result = await _db.select(
      table: DBConstants.userTable,
      where: '${DBConstants.columnEmail} = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<void> deleteAllUsers() async {
    await _db.clearTable(DBConstants.userTable);
  }
}

