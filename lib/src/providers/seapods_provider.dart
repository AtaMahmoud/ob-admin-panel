import 'package:flutter/cupertino.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/repositories/seapods_repository.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';

class SeaPodsProvider with ChangeNotifier {
  SeaPodsRepository _seaPodsRepository = SeaPodsRepository();
  ApiResponse<List<SeaPod>> _allSeapods;

  SeaPod _selectedSeapod;

  ApiResponse<List<SeaPod>> get allSeaPods => _allSeapods;
  SeaPod get selectedSeapod => _selectedSeapod;

  Future<void> getAllSeapods() async {
    _allSeapods = ApiResponse.loading('getting all seapods');
    final seapods = await _seaPodsRepository.getAllSeapods();
    _allSeapods = ApiResponse.completed(seapods);
    /* try {
      final seapods = await _seaPodsRepository.getAllSeapods();
      _allSeapods = ApiResponse.completed(seapods);
    } catch (e) {
      _allSeapods = ApiResponse.error(e.toString());
      notifyListeners();
    } */
  }

  void updateSelectedSeapod(SeaPod seaPod) {
    _selectedSeapod = seaPod;
  }
}
