import 'package:flutter/material.dart';
import 'package:jatayu/Theme.dart';

class TitleView extends StatelessWidget {
  final String title;
  final String subtitle;
  // final Function? onPressed;
  final VoidCallback? onPressed;
  TitleView({
    this.title = '',
    this.subtitle = '',
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: Style.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
                color: Style.lightText,
              ),
            ),
          ),
          (subtitle != '')
              ? InkWell(
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  onTap: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: <Widget>[
                        Text(
                          subtitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: Style.fontName,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: Style.nearlyDarkBlue,
                          ),
                        ),
                        SizedBox(
                          height: 38,
                          width: 26,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Style.darkText,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
