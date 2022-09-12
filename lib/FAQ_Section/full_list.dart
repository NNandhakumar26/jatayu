import 'package:flutter/material.dart';
import 'package:jatayu/Model/Activity.dart';
import 'package:jatayu/Screens/mainpage.dart';
import 'package:jatayu/Theme.dart';
import 'package:jatayu/Widgets/StackedImageContainer.dart';

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
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 8,
          leadingWidth: 0,
          shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
          title: CompanyAppbarRow(
            title: isFAQPage ? 'FAQ' : 'Know Your Plants',
          ),
        ),
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height / 14,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: ((context, index) => Divider(
                  color: Style.nearlyDarkBlue.withOpacity(0.16),
                )),
            itemCount: activityList.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                title: activityList[index].title ?? '',
                subtitle: activityList[index].desc ?? '',
                leading: (index + 1).toString(),
              );
            },
          ),
        ),
      ),
    );
  }
}
