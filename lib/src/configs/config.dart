class Config {
  static const String BASE_URL = 'https://oceanbuilders.herokuapp.com/v1/api/';
  static String get adminRegistration => '$BASE_URL' + 'admins/registration';
  static String get adminLogin => '$BASE_URL' + 'admins/auth';
  static String get autoLogin => '$BASE_URL' + 'admins/me';
  static String get allUsers => '$BASE_URL' + 'users';
  static String get allSeaPods => '$BASE_URL' + 'seapods';
   static String get logout => '$BASE_URL' + 'admins/logout';

  ////////////////////////////////////////////////////////
  static const int CONNECTION_TIME_OUT = 30000;
  static const int READ_TIME_OUT = 20000;
}
