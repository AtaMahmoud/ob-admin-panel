import 'package:ob_admin_panel/src/configs/config.dart';
import 'package:ob_admin_panel/src/helpers/api_base_helper.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/models/seapod_owner.dart';
import 'package:ob_admin_panel/src/singletones/headers_manager.dart';

class SeaPodsRepository {
  final _apiBaseHelper = ApiBaseHelper();
  final _headersManager = HeadersManager.getInstance();

  Future<List<SeaPod>> getAllSeapods() async {
    final headers = await _headersManager.getHeadersFromSharedPrefs();
    final response = await _apiBaseHelper.get(
      url: Config.allSeaPods,
      headers: headers,
    );
    final List<SeaPod> allSeapods = [];
    response.data.forEach((e) async {
      final seaPod = SeaPod.fromJson(e as Map<String, dynamic>);
      /*   final coordinates =
          Coordinates(seaPod.location.latitude, seaPod.location.longitude);
      var address =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      seaPod.location.locationName = address.first.countryName;
 */
      allSeapods.add(seaPod);
    });

    return allSeapods;
  }

  Future<List<SeapodOwner>> getSeapodOwners(
    String seapodId,
  ) async {
    final headers = await _headersManager.getHeadersFromSharedPrefs();
    final response = await _apiBaseHelper.get(
      url: '${Config.allSeaPods}${'/$seapodId/owner'}',
      headers: headers,
    );
    final List<SeapodOwner> seapodOwners = [];
    response.data.forEach((e) {
      seapodOwners.add(SeapodOwner.fromJson(e as Map<String, dynamic>));
    });

    return seapodOwners;
  }
}
