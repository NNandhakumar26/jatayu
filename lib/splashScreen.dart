import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jatayu/Hive/local_database.dart';
import 'package:jatayu/Registration/Registration_Controller.dart';
import 'package:jatayu/Registration/mobile_verification.dart';
import 'package:jatayu/Screens/homePage.dart';
import 'package:jatayu/Theme.dart';
import 'package:lottie/lottie.dart';

import 'Controllers/MainpageContoller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true;
  late Box mainBox;
  @override
  void initState() {
    super.initState();
    LocalDB.openMainBox();

    Future.delayed(
      Duration(seconds: 1),
      () {
        setState(
          () {
            _visible = !_visible;
          },
        );
      },
    );

    Timer(Duration(milliseconds: 2800), () async {
      await LocalDB.openMainBox().then(
        (_) {
          if (LocalDB.userID == null) {
            Get.lazyPut<MainPageController>(
              () => MainPageController(),
            );
            Get.offAll(HomePage());
          } else {
            Get.lazyPut(() => RegistrationController());
            Get.off(MobilePage());
          }
        },
      );
    });
  }

  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Style.notWhite,
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Opacity(
                opacity: 0.18,
                child: Lottie.asset(
                  'assets/json/leaves.json',
                  width: 250,
                  animate: true,
                  repeat: true,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.rotate(
                angle: 3.2,
                // angle: 1,
                child: Opacity(
                  opacity: 0.18,
                  child: Lottie.asset(
                    'assets/json/leaves.json',
                    width: 300,
                    animate: true,
                    repeat: true,
                  ),
                ),
              ),
            ),
            Positioned(
              top: Get.height / 8,
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _visible ? 0.0 : 1,
                    curve: Curves.bounceInOut,
                    duration: Duration(milliseconds: 2000),
                    child: Card(
                      elevation: 8.0,
                      shape: CircleBorder(side: BorderSide.none),
                      borderOnForeground: true,
                      shadowColor: Style.nearlyDarkBlue.withOpacity(0.60),
                      clipBehavior: Clip.antiAlias,
                      color: Style.nearlyWhite,
                      child: CircleAvatar(
                        maxRadius: 110.0,
                        backgroundColor: Style.nearlyWhite,
                        foregroundImage: AssetImage('assets/images/jatayu.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  AnimatedOpacity(
                    opacity: _visible ? 0.0 : 1,
                    curve: Curves.easeInBack,
                    duration: Duration(milliseconds: 2100),
                    child: Column(
                      children: [
                        Text(
                          'JATAYU CHARITABLE TRUST',
                          style: Style.title.copyWith(
                            color: Style.nearlyDarkBlue.withOpacity(0.87),
                            letterSpacing: 1.0,
                            fontSize: 20,
                            shadows: [
                              Shadow(
                                blurRadius: 1.0,
                                color: Style.nearlyDarkBlue.withOpacity(0.32),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            'Vidhaikalam 2.0',
                            textAlign: TextAlign.center,
                            style: Style.subtitle.copyWith(
                              color: Style.nearlyBlack.withOpacity(0.50),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                children: [
                  Text(
                    'Copyright by Jatayu Charitable Trust, 2k21.',
                    textAlign: TextAlign.justify,
                    style: Style.subtitle.copyWith(
                      color: Style.nearlyDarkBlue.withOpacity(0.87),
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Build 0.0.1  |  With ❤, NanSar.BlueOse',
                    textAlign: TextAlign.center,
                    style: Style.subtitle.copyWith(
                      color: Style.nearlyBlack.withOpacity(0.60),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
