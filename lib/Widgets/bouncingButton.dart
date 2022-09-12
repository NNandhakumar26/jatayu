import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:jatayu/Theme.dart';

class BouncingButton extends StatelessWidget {
  final String title;
  final VoidCallback voidCallback;
  final bool isHalfButton;
  final Widget? widget;
  BouncingButton({
    this.title = 'Done',
    required this.voidCallback,
    this.isHalfButton = false,
    this.widget,
  });

  _onPressed(BuildContext context) {
    Future.delayed(Duration(milliseconds: 248), () {
      voidCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Bounce(
            duration: Duration(milliseconds: 128),
            // duration: Duration(milliseconds: 500),
            onPressed: () => _onPressed(context),
            child: Container(
              height: 50,
              width: (isHalfButton) ? 164 : 270,
              decoration: BoxDecoration(
                  borderRadius: (isHalfButton)
                      ? BorderRadius.circular(8)
                      : BorderRadius.circular(64),
                  color: (isHalfButton)
                      ? Style.nearlyDarkBlue.withOpacity(0.87)
                      : Style.nearlyDarkBlue.withOpacity(0.87)),
              child: (widget == null)
                  ? Center(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontSize: (isHalfButton) ? 16 : 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    )
                  : widget!,
            ),
          ),
        ],
      ),
    );
  }
}
