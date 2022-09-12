import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jatayu/Controllers/MainpageContoller.dart';
import 'package:jatayu/Screens/homePage.dart';

class RegistrationController extends GetxController {
  late TextEditingController mobileNumberController;
  var userVerificationID;
  var otpValue;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget verificationIcon = SizedBox();
  @override
  void onInit() {
    super.onInit();
    mobileNumberController = TextEditingController();
  }

  void changeIcon(String value) {
    if ((double.tryParse(value) != null) && (value.length == 10)) {
      verificationIcon = Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 32,
      );
      update();
    } else {
      verificationIcon = Icon(
        Icons.cancel,
        color: Colors.red,
        size: 32,
      );
      update();
    }
  }

  void redirectToPage() async {
    print('entered this page $otpValue');
    print('with the user verification ID $userVerificationID');
    if (otpValue != '' && userVerificationID != null) {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: userVerificationID, smsCode: otpValue);

      var result = await _auth.signInWithCredential(credential);
      //  The result from firebase authentication SIgn in UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: true, profile: {}, providerId: null, username: null), credential: null, user: User(displayName: null, email: null, emailVerified: false, isAnonymous: false, metadata: UserMetadata(creationTime: 2021-11-05 21:21:21.893, lastSignInTime: 2021-11-05 21:21:21.893), phoneNumber: +919585447986, photoURL: null, providerData, [UserInfo(displayName: null, email: null, phoneNumber: +919585447986, photoURL: null, providerId: phone, uid: null)], refreshToken: , tenantId: null, uid: 8VwcL0wt44TGp4YIVOiiQnlWkVu2))
      print('The result from firebase authentication SIgn in $result');
      Hive.box('mainBox').put('isLoggedIn', true);
      Get.lazyPut(() => MainPageController());
      Get.offAll(HomePage());
    }
  }

  void verifyPhoneNumber(int phoneNumber) async {
    print('The phone number is +91$phoneNumber');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        userVerificationID = verificationId;
        print('code has been sent successfully');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
