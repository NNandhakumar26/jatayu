import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jatayu/Controllers/MainpageContoller.dart';
import 'package:jatayu/Course/course_main.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:jatayu/Theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(MainPageController()),
      builder: (MainPageController controller) {
        return WillPopScope(
          onWillPop: () async {
            showDialog(
              context: context,
              builder: (context) {
                return popupWidget(context);
              },
            );
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              body: SizedBox.expand(
                child: IndexedStack(
                  index: controller.selectedIndex,
                  children: [
                    controller.firstPage(),
                    controller.secondPage(),
                    controller.thirdPage(),
                    controller.fourthPage(),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CoursePage()));
                  // controller.changeIndex(controller.selectedIndex);
                },
                heroTag: 'course',
                child: Icon(
                  Icons.class_rounded,
                  color: Colors.white,
                ),
                backgroundColor: Style.nearlyDarkBlue,
              ),
              bottomNavigationBar: TitledBottomNavigationBar(
                inactiveStripColor: Style.nearlyDarkBlue.withOpacity(0.16),
                curve: Curves.bounceIn,
                currentIndex: controller.selectedIndex,
                onTap: (index) {
                  controller.selectedIndex = index;
                  controller.update();
                },
                activeColor: Style.nearlyDarkBlue.withOpacity(0.96),
                inactiveColor: Colors.black12,
                reverse: true,
                items: [
                  TitledNavigationBarItem(
                    title: Text('Home'),
                    icon: Icon(
                      Icons.home,
                    ),
                    // icon: Icons.home,
                  ),
                  TitledNavigationBarItem(
                    title: Text('Forum'),
                    // icon: Icons.question_answer_rounded,
                    icon: Padding(
                      padding: const EdgeInsets.only(
                        right: 24,
                      ),
                      child: Icon(Icons.question_answer_rounded),
                    ),
                  ),
                  TitledNavigationBarItem(
                    title: Text('LeaderBoard'),
                    // icon: Icons.badge_rounded,
                    icon: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                      ),
                      child: Icon(
                        Icons.badge_rounded,
                      ),
                    ),
                  ),
                  TitledNavigationBarItem(
                    title: Text('About'),
                    icon: Icon(
                      Icons.face,
                    ),
                    // icon: Icons.face,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AlertDialog popupWidget(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirm Exit',
        style: Style.title,
      ),
      content: Text(
        'Are you sure you want to exit?',
        style: Style.body1,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 2 / 100, horizontal: Get.width * 4 / 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: Style.subtitle,
                ),
              ),
              SizedBox(
                width: Get.width * 7 / 100,
              ),
              GestureDetector(
                onTap: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
                child: Text(
                  'Yes',
                  style: Style.subtitle.copyWith(
                    color: Style.nearlyDarkBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  // style: TextStyle(fontSize: size * 6 / 100),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
