import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning }

class CustomSnackBar {
  static void showCustomSnackBar(BuildContext context,
      {required SnackbarType type, required String message}) {
    Color? snackBarColor700;
    Color? snackBarColor900;
    IconData iconData;

    switch (type) {
      case SnackbarType.success:
        snackBarColor700 = Colors.green[700];
        snackBarColor900 = Colors.green[900];
        iconData = Icons.check_outlined;
        break;
      case SnackbarType.error:
        snackBarColor700 = Colors.red[700];
        snackBarColor900 = Colors.red[900];
        iconData = Icons.error_outline;
        break;
      case SnackbarType.warning:
        snackBarColor700 = Colors.yellow[700];
        snackBarColor900 = Colors.yellow[900];
        iconData = Icons.warning_amber_outlined;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 180,
              ),
              padding: const EdgeInsets.all(18),
              height: 80,
              decoration: BoxDecoration(
                color: snackBarColor700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 48.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type == SnackbarType.success
                              ? 'Success'
                              : type == SnackbarType.error
                                  ? 'Error'
                                  : 'Warning',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              top: 30,
              child: Icon(
                iconData,
                size: 24,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 0,
              top: -16,
              child: Icon(
                Icons.circle,
                size: 40,
                color: snackBarColor900,
              ),
            ),
            Positioned(
              left: 8,
              top: -8,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: const Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}