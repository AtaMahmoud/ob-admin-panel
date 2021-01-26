import 'package:ob_admin_panel/src/configs/config.dart';
import 'package:ob_admin_panel/src/helpers/api_base_helper.dart';
import 'package:ob_admin_panel/src/models/admin.dart';
import 'package:ob_admin_panel/src/singletones/headers_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAuthRepository {
  final _apiBaseHelper = ApiBaseHelper();
  final _headersManager = HeadersManager.getInstance();

  Future<Admin> registerAdmin(
    Admin adminData,
    String password,
  ) async {
    final data = adminData.toJson();
    data['password'] = password;
    final headers = await _headersManager.initializeBasicHeaders(adminData.email);
    final response = await _apiBaseHelper.post(
      url: Config.adminRegistration,
      data: data,
      headers: headers,
    );
    Admin authenticatedAdmin = Admin();
    authenticatedAdmin = Admin.fromJson(response.data as Map<String, dynamic>);
    final token = response.headers.value('x-auth-token');
    await _headersManager.saveAdminTokenToSharedPrefs(token);

    return authenticatedAdmin;
  }

  Future<Admin> login(
    String email,
    String password,
  ) async {
    final data = {'email': email, 'password': password};

    final headers = await _headersManager.initializeBasicHeaders(email);
    final response = await _apiBaseHelper.put(
      url: Config.adminLogin,
      data: data,
      headers: headers,
    );
    Admin authenticatedAdmin = Admin();
    authenticatedAdmin = Admin.fromJson(response.data as Map<String, dynamic>);
    final token = response.headers.value('x-auth-token');
    await _headersManager.saveAdminTokenToSharedPrefs(token);
    return authenticatedAdmin;
  }

  Future<Admin> autoLogin() async {
    final headers = await _headersManager.getHeadersFromSharedPrefs();
    if (headers['x-auth-token'] == null) return null;
    final response = await _apiBaseHelper.get(
      url: Config.autoLogin,
      headers: headers,
    );

    return Admin.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> logout() async {
    final headers = await _headersManager.getHeadersFromSharedPrefs();
    await _apiBaseHelper.post(
      url: Config.logout,
      headers: headers,
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
