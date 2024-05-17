// auth_service.dart
import 'package:neuro/database_helper.dart';

class AuthService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // Sign Up with Username and Password
  Future<bool> signUp(String username, String password) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnUsername: username,
      DatabaseHelper.columnPassword: password
    };
    final id = await _databaseHelper.insert(row);
    return id != 0;
  }

  // Sign In with Username and Password
  Future<bool> signIn(String username, String password) async {
    final allRows = await _databaseHelper.queryAllRows();
    for (var row in allRows) {
      if (row[DatabaseHelper.columnUsername] == username && row[DatabaseHelper.columnPassword] == password) {
        return true;
      }
    }
    return false;
  }
}
