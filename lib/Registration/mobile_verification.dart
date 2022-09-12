import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Registration/OTP_verification.dart';
import 'package:jatayu/Registration/Registration_Controller.dart';
import 'package:jatayu/Theme.dart';

class MobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      init: Get.put(RegistrationController()),
      builder: (RegistrationController controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xfff7f6fb),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
                      'assets/images/illustration-2.png',
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Mobile Verification Screen',
                    style: Style.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Add your phone number and we'll get started",
                    style: Style.subtitle2.copyWith(
                      fontSize: 14,
                      color: Colors.black45,
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
                        TextFormField(
                          controller: controller.mobileNumberController,
                          onChanged: (String text) {
                            if (text.length >= 9) {
                              controller.changeIcon(text);
                            }
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            prefix: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '(+91)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            suffixIcon: controller.verificationIcon,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller
                                      .mobileNumberController.text.length ==
                                  10) {
                                controller.verifyPhoneNumber(int.parse(
                                    controller.mobileNumberController.text));
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OTPVerificationPage()),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                                'Send',
                                style: Style.button.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
