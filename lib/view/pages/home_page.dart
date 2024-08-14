import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../lib_old/screens/home_item/date_selector.dart';
import '../../../lib_old/screens/home_item/home_top_section.dart';
import '../../../lib_old/screens/home_item/task_list.dart';
import '../../services/ad_manager.dart';

///画面全体
class HomePage extends StatelessWidget {
  late AdManager adManager;

  HomePage() {
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
            if (adManager.bannerAd != null)
              Container(
                alignment: Alignment.center,
                child: AdWidget(ad: adManager.bannerAd),
                width: adManager.bannerAd.size.width.toDouble(),
                height: adManager.bannerAd.size.height.toDouble(),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
