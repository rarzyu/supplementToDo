import 'package:flutter/material.dart';
import '../../config/constants/color.dart';

///タイトル部分
class AddEditSectionTitle extends StatelessWidget {
  final Icon icon;
  final String title;

  AddEditSectionTitle({
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
