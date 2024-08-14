import 'package:flutter/material.dart';

/// アラート集
/// - 汎用的に使えるもの中心
class AlertComponent {
  
  /// 汎用アラート
  /// - OKで閉じるだけ
  /// @param context(BuildContext)：コンテキスト
  /// @param title(String)：タイトル
  /// @param message(String)：メッセージ
  /// @param icon(Icon)：アラートのアイコン
  void showGeneralMessageAlert(
      BuildContext context, String title, String message, Icon icon) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                icon,
                const SizedBox(
                  width: 10,
                ),
                Text(title),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}
