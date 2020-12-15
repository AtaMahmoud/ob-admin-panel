import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class HeadersManager {
  static final HeadersManager _headersManagerSingleton =
      HeadersManager._internal();
  HeadersManager._internal();

  static HeadersManager getInstance() => _headersManagerSingleton;

  Future<Map<String, String>> getBasicHeaders(
    String email,
  ) async {
    Map<String, String> deviceData = {};
    deviceData['content-type'] = 'application/json';
    deviceData['notificationToken'] =
        'fluMksedKxY:APA91bFMdxZD7Ouwh0aiVWuDcLrzPfNMkU6WbH_zljlCm_57samv/g3hLcsrcM9MkA45568IUWCnXI-7cBEMrl6NLtfqlauc8Wssa-xN5vXXFS2hb7mka0y1RJ698...';
    deviceData['hardwareId'] = email;
    deviceData['Access-Control-Allow-Origin'] = '*';

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (UniversalPlatform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo =
          await deviceInfoPlugin.androidInfo;
      //deviceData['hardwareId'] = androidDeviceInfo.androidId;
      deviceData['model'] = androidDeviceInfo.model;
    } else if (UniversalPlatform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      //deviceData['hardwareId'] = iosDeviceInfo.identifierForVendor;
      deviceData['model'] = iosDeviceInfo.model;
    } else {
      // deviceData['hardwareId'] = "";
      deviceData['model'] = "application/json";
    }

    return deviceData;
  }

  Future<Map<String, String>> initializeBasicHeaders(String email) async {
    var headers = await getBasicHeaders(email);
    await _saveHeadersToSharedPrefs(headers);

    return headers;
  }

  Future<Map<String, String>> getHeadersFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> resultMap = {};
    if (sharedPreferences.containsKey('content-type')) {
      resultMap['content-type'] = sharedPreferences.getString('content-type');
      resultMap['notificationToken'] =
          sharedPreferences.getString('notificationToken');
      resultMap['hardwareId'] = sharedPreferences.getString('hardwareId');
      resultMap['Access-Control-Allow-Origin'] =
          sharedPreferences.get('Access-Control-Allow-Origin');
      resultMap['model'] = sharedPreferences.getString('model');
      resultMap['x-auth-token'] = sharedPreferences.getString('x-auth-token');
    }
    return resultMap;
  }

  Future<void> _saveHeadersToSharedPrefs(
      Map<String, dynamic> deviceData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (var key in deviceData.keys) {
      sharedPreferences.setString(key, deviceData[key]);
    }
  }

  Future<void> saveAdminTokenToSharedPrefs(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('x-auth-token', token);
  }

  /*  Future<String> getAdminTokenFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('x-auth-token');
  } */
}
