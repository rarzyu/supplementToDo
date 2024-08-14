import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'add_edit_item/add_edit_bottom_section.dart';
import 'add_edit_item/classification_item.dart';
import 'add_edit_item/detail_item.dart';
import 'add_edit_item/repeat_item.dart';
import 'add_edit_item/task_title_item.dart';
import '../services/ad_manager.dart';
import 'add_edit_item/add_edit_top_section.dart';
import 'add_edit_item/scheduled_date_item.dart';
import 'add_edit_item/scheduled_time_item.dart';

class AddEditScreen extends StatelessWidget {
  late AdManager adManager;

  AddEditScreen() {
    adManager = AdManager();
  }

  dispose() {
    adManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // キーボードが表示されている場合、キーボードを隠す
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddEditTopSection(),
                ScheduledDate(),
                SheduledTime(),
                // Repeat(),
                TaskTitle(),
                Classification(),
                Details(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (adManager.bannerAd != null)
              Container(
                alignment: Alignment.center,
                child: AdWidget(ad: adManager.bannerAd),
                width: adManager.bannerAd.size.width.toDouble(),
                height: adManager.bannerAd.size.height.toDouble(),
              ),
            AddEditBottom(),
          ],
        ),
      ),
    );
  }
}
