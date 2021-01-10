import 'package:flutter/cupertino.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/models/seapod_owner.dart';
import 'package:ob_admin_panel/src/repositories/seapods_repository.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';

class SeaPodsProvider with ChangeNotifier {
  SeaPodsRepository _seaPodsRepository = SeaPodsRepository();
  ApiResponse<List<SeaPod>> _allSeapods;
  SeapodOwner selectedOwner;

  SeaPodsProvider() {
    _allSeapods = ApiResponse<List<SeaPod>>();
  }

  SeaPod _selectedSeapod;

  ApiResponse<List<SeaPod>> get allSeaPods => _allSeapods;
  SeaPod get selectedSeapod => _selectedSeapod;

  Future<void> getAllSeapods() async {
    try {
      final seapods = await _seaPodsRepository.getAllSeapods();
      _allSeapods = ApiResponse.completed(seapods);
    } catch (e) {
      _allSeapods = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  void updateSelectedSeapod(SeaPod seaPod) {
    _selectedSeapod = seaPod;
  }

  void updateSelectedOwner(SeapodOwner owner) {
    selectedOwner = owner;
  }

  Future<void> getSeapodOwners() async {
    _selectedSeapod.owners =
        await _seaPodsRepository.getSeapodOwners(_selectedSeapod.id);
   
  }
}
