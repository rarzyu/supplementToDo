import 'dart:io';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  late BannerAd bannerAd;
  InterstitialAd? interstitialAd;

  static const retryMaxCount = 3; // 最大リトライ回数
  int retryCount = 0; // リトライ回数

  var random = Random().nextInt(100); // 0~99の乱数
  static const adRate = 40; // 広告表示率

  AdManager() {
    _createBannerAd();
    _createInterstitialAd();
  }

  String get bannerAdUnitId {
    bool isDebug = false;
    assert(isDebug = true);

    if (Platform.isAndroid) {
      return isDebug
          ? dotenv.env['ADMOB_BANNER_ID_ANDROID_TEST'] ?? ''
          : dotenv.env['ADMOB_BANNER_ID_ANDROID'] ?? '';
    } else if (Platform.isIOS) {
      return isDebug
          ? dotenv.env['ADMOB_BANNER_ID_IOS_TEST'] ?? ''
          : dotenv.env['ADMOB_BANNER_ID_IOS'] ?? '';
    }
    return '';
  }

  String get interstitialAdUnitId {
    bool isDebug = false;
    assert(isDebug = true);

    if (Platform.isAndroid) {
      return isDebug
          ? dotenv.env['ADMOB_INTERSTITIAL_ID_ANDROID_TEST'] ?? ''
          : dotenv.env['ADMOB_INTERSTITIAL_ID_ANDROID'] ?? '';
    } else if (Platform.isIOS) {
      return isDebug
          ? dotenv.env['ADMOB_INTERSTITIAL_ID_IOS_TEST'] ?? ''
          : dotenv.env['ADMOB_INTERSTITIAL_ID_IOS'] ?? '';
    }
    return '';
  }

  void _createBannerAd() {
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          print('Banner Ad Loaded');
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner Ad Failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          print('Interstitial Ad Loaded');
        },
        onAdFailedToLoad: (error) {
          print('Interstitial Ad Failed to load: $error');

          // リトライ
          if (retryCount < retryMaxCount) {
            retryCount++;
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  showInterstitialAd() {
    if (interstitialAd != null) {
      if (random < adRate) {
        interstitialAd!.show();
        interstitialAd = null;
      }
    } else {
      _createInterstitialAd();
    }
    random = Random().nextInt(100);
  }

  void dispose() {
    bannerAd.dispose();
    interstitialAd?.dispose();
  }
}
