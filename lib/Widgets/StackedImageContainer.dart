import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:jatayu/modals/Activity.dart';
import 'package:jatayu/Widgets/IndividualScreen.dart';
import '../Theme.dart';

class StackedImageContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Activity activity;
  StackedImageContainer({
    this.title = '',
    this.subtitle = 'Learn What\'s The Next Step',
    required this.activity,
  });

  _onPressed(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 248),
      () {
        Style.navigateBack(
          context,
          IndividualPage(activity),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 128),
      onPressed: () => _onPressed(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        height: 72,
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Style.grey.withOpacity(0.32),
              offset: Offset(0.8, 1.6),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Positioned(
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: SizedBox(
                  height: Get.height / 10,
                  width: Get.width / 2.6,
                  child: Image.asset("assets/images/back.png"),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 220,
                child: CustomListTile(title: title, subtitle: subtitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.leading,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String? leading;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 14,
      onTap: () => (onTap != null) ? onTap!() : null,
      leading: (leading != null)
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                leading!,
                textAlign: TextAlign.right,
                textHeightBehavior: TextHeightBehavior(),
                style: Style.headline.copyWith(
                  fontSize: 18,
                  color: Colors.black38,
                  // color: Style.nearlyDarkBlue.withOpacity(0.45),
                ),
              ),
            )
          : null,
      title: Text(title,
          textAlign: TextAlign.left,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              )),
      isThreeLine: (leading != null) ? true : false,
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          subtitle,
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontSize: (leading != null) ? 14 : 12,
                letterSpacing: -0.2,
                color: Colors.black.withOpacity(0.60),
              ),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Style.nearlyDarkBlue.withOpacity(0.87),
        size: 16,
      ),
    );
  }
}
