import 'package:flutter/material.dart';
import 'package:jatayu/modals/Activity.dart';
import 'package:jatayu/Theme.dart';
import 'package:jatayu/Widgets/StackedImageContainer.dart';

import '../Widgets/IndividualScreen.dart';
import '../Widgets/appbars.dart';

class FullListPage extends StatelessWidget {
  final List<Activity> activityList;
  final isFAQPage;

  FullListPage({
    required this.activityList,
    required this.isFAQPage,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: DefaultAppbar(
          title: (isFAQPage) ? 'FAQ' : 'Know Your Plants',
        ),
        preferredSize: Size(
          double.infinity,
          56,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: ((context, index) => Divider(
                  height: 0.8,
                  thickness: 0.8,
                  color: Colors.black12,
                )),
            itemCount: activityList.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                title: activityList[index].title ?? '',
                subtitle: activityList[index].desc ?? '',
                leading: (index + 1).toString(),
                onTap: () => Style.navigateBack(
                  context,
                  IndividualPage(activityList[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
