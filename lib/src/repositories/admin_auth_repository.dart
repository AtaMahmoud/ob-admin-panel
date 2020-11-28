import 'package:ob_admin_panel/src/configs/config.dart';
import 'package:ob_admin_panel/src/helpers/api_base_helper.dart';
import 'package:ob_admin_panel/src/models/admin.dart';
import 'package:ob_admin_panel/src/singletones/headers_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAuthRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  HeadersManager _headersManager = HeadersManager.getInstance();

  Future<Admin> registerAdmin(
    Admin adminData,
    String password,
  ) async {
    var data = adminData.toJson();
    data['password'] = password;
    var headers = await _headersManager.initializeBasicHeaders(adminData.email);
    final response = await _apiBaseHelper.post(
      url: Config.adminRegistration,
      data: data,
      headers: headers,
    );
    Admin authenticatedAdmin = Admin();
    authenticatedAdmin = Admin.fromJson(response.data);
    var token = response.headers.value('x-auth-token');
    await _headersManager.saveAdminTokenToSharedPrefs(token);

    return authenticatedAdmin;
  }

  Future<Admin> login(
    String email,
    String password,
  ) async {
    var data = {'email': email, 'password': password};

    var headers = await _headersManager.initializeBasicHeaders(email);
    final response = await _apiBaseHelper.put(
      url: Config.adminLogin,
      data: data,
      headers: headers,
    );
    Admin authenticatedAdmin = Admin();
    authenticatedAdmin = Admin.fromJson(response.data);
    var token = response.headers.value('x-auth-token');
    await _headersManager.saveAdminTokenToSharedPrefs(token);
    return authenticatedAdmin;
  }

  Future<Admin> autoLogin() async {
    var headers = await _headersManager.getHeadersFromSharedPrefs();
    if (headers['x-auth-token'] == null) return null;
    final response = await _apiBaseHelper.get(
      url: Config.autoLogin,
      headers: headers,
    );

    return Admin.fromJson(response.data);
  }

  Future<void> logout() async {
    var headers = await _headersManager.getHeadersFromSharedPrefs();
    await _apiBaseHelper.post(
      url: Config.logout,
      headers: headers,
    );

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
