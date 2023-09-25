import 'package:flutter/material.dart';

class CustomDialog {
  final String title;
  final String content;
  final List<Widget> actions;

  CustomDialog({
    required this.title,
    required this.content,
    required this.actions,
  });

  Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          // Gunakan Center widget untuk menempatkan dialog di tengah layar
          child: AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions,
          ),
        );
      },
    );
  }
}
