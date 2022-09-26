import 'package:flutter/material.dart';

import 'Widgets/loading_dialog.dart';

extension IntExtensions on int? {
  /// Leaves given height of space
  Widget get height => SizedBox(height: this?.toDouble());

  /// Leaves given width of space
  Widget get width => SizedBox(width: this?.toDouble());
}

extension StringExtensions on String? {
  /// Leaves given height of space
  Widget get plainText => Text(this ?? '');

  Widget get centerText => Text(
        this ?? '',
        textAlign: TextAlign.center,
      );

  Widget get underlineText => Text(
        this ?? '',
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      );

  Widget get subTitle => Text(
        this ?? '',
        style: TextStyle(
          color: Colors.grey.shade400,
        ),
      );

  Widget get showLoading => Dialog(
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.grey.shade300,
              ),
              16.width,
              Expanded(
                child: Text(
                  this ?? '',
                  textAlign: TextAlign.center,
                  // style: Theme.of(context).textTheme.button!.copyWith(
                  //       fontSize: 14,
                  //       color: Colors.black87,
                  //     ),
                ),
              )
            ],
          ),
        ),
      );
}

class Style {
  Style._();

  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color online = Color(0xFF4BCB1F);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';
  static const randomColours = [
    Color(0xffAB8FF4),
    Color(0xffE39AE0),
    Color(0xff85ADEA),
    Color(0xff66D3C5),
  ];

  static InputDecoration decoration = InputDecoration(
    filled: true,
    fillColor: Style.notWhite.withOpacity(0.87),
    hintText: "Write Some Comments...",
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Style.nearlyDarkBlue,
        width: 0.3,
      ),
      borderRadius: BorderRadius.circular(4),
      gapPadding: 4,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Style.nearlyDarkBlue,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(4),
      gapPadding: 4,
    ),
    hintStyle: Style.caption,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Style.nearlyDarkBlue,
        width: 0.3,
      ),
      borderRadius: BorderRadius.circular(4),
      gapPadding: 4,
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),

    // labelText: 'First Name',
    labelStyle: TextStyle(
      fontSize: 14,
      // fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.87),
      letterSpacing: 1.0,
    ),
  );

  static InputDecoration inputTextDecoration({String title = ''}) {
    return InputDecoration(
      filled: true,
      fillColor: Style.nearlyWhite.withOpacity(0.87),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelText: title,
      floatingLabelStyle: Style.caption.copyWith(
        color: Style.nearlyDarkBlue,
        letterSpacing: 0.4,
        fontSize: 14,
      ),
      labelStyle: Style.subtitle2.copyWith(
        color: Style.lightText.withOpacity(0.32),
        // fontSize: 14,
        // letterSpacing: 0.4,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 0.4,
          color: Style.lightText,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 1.2,
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 1.6,
          color: Style.nearlyDarkBlue,
        ),
      ),
    );
  }

  static TextStyle errorText = TextStyle(
    fontSize: 12,
    color: Colors.white.withOpacity(0.87),
  );

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static InputDecoration inputFieldDecorationWithoutLabel({String title = ''}) {
    return InputDecoration(
      filled: true,
      fillColor: Style.nearlyDarkBlue.withOpacity(0.016),
      hintText: title,
      hintStyle: Style.subtitle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        letterSpacing: 0.8,
        color: Colors.black12,
      ),

      contentPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black12,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Style.nearlyDarkBlue.withOpacity(0.60),
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      // hintText: title,
    );
  }

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontName,
    // fontWeight: FontWeight.w400,
    // fontSize: 14,
    // letterSpacing: -0.04,
    color: darkText,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.25,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    // fontWeight: FontWeight.w400,
    // fontSize: 16,
    // letterSpacing: -0.05,
    color: darkText,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.4,
    color: lightText, // was lightText
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    fontFamily: fontName,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    fontFamily: fontName,
  );
  static Future<T?> navigate<T>(BuildContext context, Widget widget) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      PageRouteBuilder<T>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  static Future<T?> navigateBack<T>(BuildContext context, Widget widget) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionsBuilder:
            (___, Animation<double> animation, ____, Widget child) {
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
          // return FadeTransition(
          //   opacity: animation,
          //   child: RotationTransition(
          //     turns:
          //         Tween<double>(begin: 0.5, end: 1.0)
          //             .animate(animation),
          //     child: child,
          //   ),
          // );
        },
      ),
    );
  }

// TODO: merge this hide keyboard function with the loading dialog
  static hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  static Future loadingDialog(BuildContext context,
      {Widget? widget, String? title, bool barrierDismissible = true}) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => (widget != null)
          ? widget
          : CustomLoadingDialog(
              title: title ?? '',
            ),
    );
  }

  static void showSnackBar(BuildContext context, String message,
          {bool isError = false}) async =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: message.plainText,
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        ),
      );
}
