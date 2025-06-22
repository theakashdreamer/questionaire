import 'package:flutter/material.dart';
import 'package:questionaire/mvvm_implementation/core/constants/hash_helper.dart' show HashHelper;
import 'package:questionaire/mvvm_implementation/core/constants/shared_pref_helper.dart' show SharedPrefHelper;
import 'package:questionaire/mvvm_implementation/core/database/user_dao.dart' show UserDAO;
import 'package:questionaire/mvvm_implementation/core/model/user_model.dart' show UserModel;


class AuthViewModel extends ChangeNotifier {
  final UserDAO _userDAO = UserDAO();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Register user with hashed password
  Future<bool> register(String email, String password) async {
    _setLoading(true);

    try {
      final existingUser = await _userDAO.getUserByEmail(email);
      if (existingUser != null) {
        _setLoading(false);
        return false; // User already exists
      }

      final hashed = HashHelper.hashPassword(password);
      final user = UserModel(email: email, password: hashed);
      await _userDAO.registerUser(user);

      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }
  Future<void> printUsers() async {
    await _userDAO.printAllUsers();
  }


  /// Login with hash check and save session
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    final hashed = HashHelper.hashPassword(password);
    final user = await _userDAO.loginUser(email, hashed);
    if (user != null) {
      await SharedPrefHelper().setLogin(true, user.email);
    }
    _setLoading(false);
    return user != null;
  }

  /// Optional: logout logic
  Future<void> logout() async {
    await SharedPrefHelper().logout();
    notifyListeners();
  }
}
