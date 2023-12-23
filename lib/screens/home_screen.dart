import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supplement_to_do/screens/home_item/date_selector.dart';
import 'package:supplement_to_do/screens/home_item/home_top_section.dart';
import 'package:supplement_to_do/screens/home_item/task_list.dart';
import 'package:supplement_to_do/services/ad_manager.dart';

///画面全体
class HomeScreen extends StatelessWidget {
  late AdManager adManager;

  HomeScreen() {
    adManager = AdManager();
  }

  dispose() {
    adManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //リスト
      body: SafeArea(
        child: Column(
          children: [
            TopSection(),
            DateSelector(),
            TaskList(),
            // if (adManager.bannerAd != null)
            Container(
              alignment: Alignment.center,
              child: AdWidget(ad: adManager.bannerAd),
              width: adManager.bannerAd.size.width.toDouble(),
              height: adManager.bannerAd.size.height.toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}
