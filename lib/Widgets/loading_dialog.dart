import 'package:flutter/material.dart';

import '../Theme.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String title;
  const CustomLoadingDialog({this.title = 'Loading...', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            CircularProgressIndicator(
              color: Style.nearlyDarkBlue.withOpacity(0.87),
            ),
            16.width,
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button!.copyWith(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
