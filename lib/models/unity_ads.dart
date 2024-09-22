import 'package:flutter/foundation.dart';

class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '5646953';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return '5646952';
    }
    return '';
  }

  static String get bannerAdPlacementId {
    return 'Banner_Android';
  }

  static String get interstitialVideoAdPlacementId {
    return 'Interstitial_iOS';
  }

  static String get rewardedVideoAdPlacementId {
    return 'Rewarded_iOS';
  }
}
