import 'package:flutter/material.dart';
import 'package:jatayu/faq/full_list.dart';
import 'package:jatayu/modals/Activity.dart';
import 'package:jatayu/database/network_database.dart';
import 'package:jatayu/Screens/custom_future_builder.dart';

import 'package:jatayu/Theme.dart';
import 'package:jatayu/Widgets/IndividualScreen.dart';
import 'package:jatayu/Widgets/StackedImageContainer.dart';
import 'package:jatayu/Widgets/titleView.dart';

import '../Widgets/appbars.dart';

class FAQPage extends StatelessWidget {
  final knowYourPlants = <Activity>[];
  final faq = <Activity>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 8,
          leadingWidth: 0,
          shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
          title: CompanyAppbar(),
        ),
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height / 14,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.live_help,
          color: Colors.white,
        ),
        backgroundColor: Style.nearlyDarkBlue.withOpacity(0.87),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.87,
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: TitleView(
                            title: 'Know Your Plants',
                            subtitle: 'More',
                            onPressed: () {
                              Style.navigateBack(
                                context,
                                FullListPage(
                                  activityList: knowYourPlants,
                                  isFAQPage: false,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: CustomFutureBuilder<List<Activity>>(
                          onSuccessWidget: (value) {
                            knowYourPlants.addAll(value);
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  StackedImageContainer(
                                title: value[index].title ?? '',
                                activity: value[index],
                              ),
                            );
                          },
                          futureFunction: Network.readActivities(
                            GetPost.knowYourPlants,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TitleView(
                  title: 'Frequently Asked Questions',
                  subtitle: 'More',
                  onPressed: () {
                    Style.navigateBack(
                      context,
                      FullListPage(
                        activityList: faq,
                        isFAQPage: true,
                      ),
                    );
                  },
                ),
                CustomFutureBuilder<List<Activity>>(
                  onSuccessWidget: (value) {
                    faq.addAll(value);
                    return Column(
                      children: [0, 1, 2]
                          .map(
                            (index) => InkWell(
                              onTap: () {
                                Style.navigateBack(
                                    context, IndividualPage(value[index]));
                              },
                              child: FAQContainer(
                                title: value[index].title ?? 'No Title',
                                json: 'purplePlantSingle',
                                subTitle: value[index].desc ?? 'No Subtitle',
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                  futureFunction: Network.readActivities(
                    GetPost.faq,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FAQContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String json;
  FAQContainer(
      {required this.title,
      required this.subTitle,
      this.json = 'purplePlantSingle'});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 24,
      ),
      padding: EdgeInsets.all(20),
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 249, 249, 253),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topRight: Radius.circular(48.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Style.grey.withOpacity(0.4),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 11,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Style.subtitle.copyWith(
                color: Style.nearlyDarkBlue,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              subTitle,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.left,
              style: Style.subtitle.copyWith(
                fontFamily: Style.fontName,
                color: Style.lightText.withOpacity(0.72),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
