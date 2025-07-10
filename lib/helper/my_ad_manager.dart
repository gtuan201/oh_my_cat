import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyAdManager {
  InterstitialAd? _interstitialAd;

  Future<void> loadAd() async {
    await InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          print('Interstitial ad loaded.');

          _interstitialAd!.setImmersiveMode(true);
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('Ad dismissed.');
              ad.dispose();
              loadAd();
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              print('Failed to show: $err');
              ad.dispose();
              loadAd();
            },
          );
        },
        onAdFailedToLoad: (err) {
          print('Failed to load interstitial ad: $err');
          _interstitialAd = null;
        },
      ),
    );
  }

  void showAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      print('Ad is not ready yet.');
    }
  }
}
