import 'package:flutter/material.dart';
import '../../../../lib/constants/color_constant.dart';

///タイトル部分
class AddEditSectionTitleComponent extends StatelessWidget {
  final Icon icon;
  final String title;

  AddEditSectionTitleComponent({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sectionTitleLightGray,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 8.0,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.fontBlackBold),
          ),
        ],
      ),
    );
  }
}
