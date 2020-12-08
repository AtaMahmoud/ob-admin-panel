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
    response.data.forEach((e) async {
      var seaPod = SeaPod.fromJson(e);
     /*  final coordinates =
          Coordinates(seaPod.location.latitude, seaPod.location.longitude);
      var address =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      seaPod.location.locationName = address.first.countryName;
 */
      allSeapods.add(seaPod);
    });

    return allSeapods;
  }
}
