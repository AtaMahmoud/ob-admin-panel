// ignore: avoid_classes_with_only_static_members
class Config {
  static const String baseUrl = 'https://oceanbuilders.herokuapp.com/v1/api/';
  static String get adminRegistration => '${baseUrl}admins/registration';
  static String get adminLogin => '${baseUrl}admins/auth';
  static String get autoLogin => '${baseUrl}admins/me';
  static String get allUsers => '${baseUrl}users';
  static String get allSeaPods => '${baseUrl}seapods';
  static String get logout => '${baseUrl}admins/logout';

  ////////////////////////////////////////////////////////
  static const int connectionTimeOut = 30000;
  static const int readTimeOut = 20000;
}
