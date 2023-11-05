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
      color: AppColors.borderGray,
      child: Row(
        children: [
          icon,
          Text(title),
        ],
      ),
    );
  }
}
