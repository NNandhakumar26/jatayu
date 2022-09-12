import 'package:get/get.dart';
import 'package:jatayu/About_Section/about.dart';
import 'package:jatayu/About_Section/aboutController.dart';
import 'package:jatayu/FAQ_Section/faq.dart';
import 'package:jatayu/LeaderBoard/leaderBoard.dart';
import 'package:jatayu/LeaderBoard/leaderBoardController.dart';
import 'package:flutter/material.dart';
import 'package:jatayu/Screens/mainpage.dart';

class MainPageController extends GetxController {
  var selectedIndex = 0;

  Widget firstPage() {
    //since it is already initialized
    // Get.lazyPut(() => MainPageController());
    return MainPage();
  }

  Widget secondPage() {
    return FAQPage();
  }

  Widget thirdPage() {
    Get.lazyPut(() => LeaderBoardController());
    return LeaderBoardPage();
  }

  Widget fourthPage() {
    Get.lazyPut(() => AboutController(), fenix: true);
    return AboutPage();
  }
}
