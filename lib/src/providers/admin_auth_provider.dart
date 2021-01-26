import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/models/admin.dart';
import 'package:ob_admin_panel/src/repositories/admin_auth_repository.dart';

class AdminAuthProvider with ChangeNotifier {
  AdminAuthRepository _adminAuthRepository = AdminAuthRepository();
  ApiResponse<Admin> _authenticatedAdmin;

  AdminAuthProvider() {
    _adminAuthRepository = AdminAuthRepository();
    _authenticatedAdmin = ApiResponse<Admin>();
  }

  Admin get authenticatedAdmin => _authenticatedAdmin.data;

  Future<void> register(Admin adminData, String password) async {
    _authenticatedAdmin = ApiResponse.loading('Create account');
    notifyListeners();
    try {
      final admin =
          await _adminAuthRepository.registerAdmin(adminData, password);
      _authenticatedAdmin = ApiResponse.completed(admin);
      notifyListeners();
    } catch (e) {
      _authenticatedAdmin = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    _authenticatedAdmin = ApiResponse.loading('Login');
    //notifyListeners();
    try {
      final admin = await _adminAuthRepository.login(email, password);
      _authenticatedAdmin = ApiResponse.completed(admin);
      // notifyListeners();
    } catch (e) {
      _authenticatedAdmin = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<bool> autoLogin() async {
    final admin = await _adminAuthRepository.autoLogin();
    if (admin != null) {
      _authenticatedAdmin = ApiResponse.completed(admin);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await _adminAuthRepository.logout();
    _authenticatedAdmin = null;
  }
}
