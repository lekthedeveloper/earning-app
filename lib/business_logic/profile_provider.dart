import 'package:flutter/foundation.dart';
import '../models/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? _profile;

  ProfileModel? get profile => _profile;

  void profileDetails(ProfileModel profile) {
    _profile = profile;
    notifyListeners();
  }

  void clearProfileStoredData() {
    _profile = null;
    notifyListeners();
  }
}
