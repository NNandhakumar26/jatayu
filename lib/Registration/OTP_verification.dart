import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Registration/Registration_Controller.dart';
import 'package:jatayu/Screens/homePage.dart';

import '../Theme.dart';

class OTPVerificationPage extends GetView<RegistrationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (RegistrationController controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Style.nearlyDarkBlue.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/illustration-3.png',
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter your OTP code number",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                              width: Get.width,
                              height: 120,
                              child: TextFormField(
                                onChanged: (String text) {
                                  if (int.tryParse(text) != null) {
                                    controller.otpValue = text;
                                  }
                                },
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.black87,
                                  letterSpacing: 2.4,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.redirectToPage();
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Style.nearlyDarkBlue.withOpacity(0.87)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Verify',
                                  style: Style.button.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Didn't you receive any code?",
                      style: Style.subtitle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Resend New Code",
                      style: Style.body1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Style.nearlyDarkBlue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextFieldOTP extends StatelessWidget {
  final bool first;
  final bool last;
  TextFieldOTP({
    required this.first,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (RegistrationController controller) {
        return Flexible(
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.black38,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 4.8,
                  color: Style.nearlyDarkBlue.withOpacity(0.87),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}
