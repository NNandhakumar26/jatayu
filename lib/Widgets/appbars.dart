import 'package:flutter/material.dart';

import '../Screens/chat_screen.dart';
import '../Theme.dart';

class CompanyAppbar extends StatelessWidget {
  final String? title;
  const CompanyAppbar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? 'Jatayu Charitable Trust',
          style: Style.headline.copyWith(
            color: Style.nearlyDarkBlue.withOpacity(0.87),
            letterSpacing: -0.4,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
              iconSize: 18,
              splashColor: Style.nearlyDarkBlue.withOpacity(0.32),
              splashRadius: 20,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const ChatScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.forum_rounded,
                color: Colors.black54,
              ),
              iconSize: 18,
              splashColor: Style.nearlyDarkBlue.withOpacity(0.32),
              splashRadius: 20,
            ),
          ],
        )
      ],
    );
  }
}

class DefaultAppbar extends StatelessWidget {
  final String title;
  final List<Widget>? actionWidgets;
  final bool hasBackButton;
  const DefaultAppbar({
    Key? key,
    required this.title,
    this.actionWidgets,
    this.hasBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      shadowColor: Style.nearlyDarkBlue.withOpacity(0.48),
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: Style.headline.copyWith(
          color: Style.nearlyDarkBlue.withOpacity(0.87),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // leadingWidth: (hasBackButton) ? 18 : 0,
      leading: Visibility(
        visible: hasBackButton,
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 24,
            color: Colors.grey.shade600,
          ),
        ),
      ),
      actions: actionWidgets,
    );
  }
}
