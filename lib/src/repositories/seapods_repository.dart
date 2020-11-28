import 'package:ob_admin_panel/src/configs/config.dart';
import 'package:ob_admin_panel/src/helpers/api_base_helper.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/singletones/headers_manager.dart';

class SeaPodsRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  HeadersManager _headersManager = HeadersManager.getInstance();

  Future<List<SeaPod>> getAllSeapods() async {
    var headers = await _headersManager.getHeadersFromSharedPrefs();
    final response = await _apiBaseHelper.get(
      url: Config.allSeaPods,
      headers: headers,
    );
    List<SeaPod> allSeapods = List<SeaPod>();
    response.data.forEach((seapod) {
      allSeapods.add(SeaPod.fromJson(seapod));
    });
    return allSeapods;
  }
}
