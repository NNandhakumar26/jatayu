import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jatayu/Theme.dart';

import '../services/auth_controller.dart';
import '../services/validators.dart';

class PhoneAuthenticationPage extends StatefulWidget {
  // const PhoneAuthenticationPage({super.key});

  @override
  State<PhoneAuthenticationPage> createState() =>
      _PhoneAuthenticationPageState();
}

class _PhoneAuthenticationPageState extends State<PhoneAuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  bool isContactNumberPage = true;
  String? contactNumber;
  String? otp;
  String? verificationId;
  Timer? timer;
  int secondsRemaining = 60;
  bool enableResend = false;

  void initializeTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if ((timer != null) && (timer!.isActive)) timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Expanded(
                  child: Text(
                    (isContactNumberPage)
                        ? "Phone Number Authentication"
                        : 'OTP Verfication',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // 70.height,
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: Card(
                    margin: EdgeInsets.all(8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (isContactNumberPage)
                              ? TextField(
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  // validator: (value) => Validators.isValidPhoneNumber(value!)
                                  //     ? null
                                  //     : 'Invalid Contact Number',
                                  onChanged: (value) => contactNumber = value,

                                  decoration: const InputDecoration(
                                    labelText: "Contact Number",
                                  ),
                                )
                              : Column(
                                  children: [
                                    12.height,
                                    'OTP has been sent to the number'
                                        .centerText,
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        contactNumber.toString(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    8.height,
                                    TextField(
                                      keyboardType: TextInputType.number,
                                      autocorrect: false,
                                      // validator: (value) => Validators.isValidPhoneNumber(value!)
                                      //     ? null
                                      //     : 'Invalid Contact Number',
                                      onChanged: (value) => otp = value,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "OTP Number",
                                      ),
                                    ),
                                    8.height,
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (!timer!.isActive)
                                            Text(
                                              'Did Not Receive OTP?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          TextButton(
                                            onPressed: () {
                                              enableResend
                                                  ? _resendCode()
                                                  : null;
                                            },
                                            child: Text(
                                              secondsRemaining == 0
                                                  ? "Resend OTP"
                                                  : "OTP expires in ${secondsRemaining.toString()} Seconds",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          24.height,
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              child: Text(
                                (isContactNumberPage)
                                    ? "Send OTP"
                                    : 'Verify OTP',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              // color: Colors.black,
                              // elevation: 15.0,
                              // shape: StadiumBorder(),
                              // splashColor: Colors.white54,
                              onPressed: () => (isContactNumberPage)
                                  ? contactNumberRegistration()
                                  : validateOtp(),
                            ),
                          ),
                          8.height,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resendCode() async {
    contactNumberRegistration();
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
    initializeTimer();
  }

  void contactNumberRegistration() async {
    if (Validators.isValidPhoneNumber(contactNumber)) {
      showSnackBar('Please wait...');
      // hide the keyboard if it is open

      FocusManager.instance.primaryFocus?.unfocus();

      final auth = AuthController.auth;

      await auth.verifyPhoneNumber(
        phoneNumber: '+91$contactNumber',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('verification Completed function');
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          if (userCredential.user != null) {
            if (!mounted) return;
            AuthController.registrationNavigation(context, userCredential);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('verification failed');
          if (e.code == 'invalid-phone-number') {
            showSnackBar('The provided phone number is not valid.');
          }
        },
        codeSent: (String thisVerificationId, int? resendToken) async {
          print('code sent function');
          setState(() {
            isContactNumberPage = false;
            verificationId = thisVerificationId;
          });
          showSnackBar('OTP has been sent successfully');
          initializeTimer();
        },
        codeAutoRetrievalTimeout: (String thisVerificationId) {
          print('Inside code auto retrieval timeout');
          verificationId = thisVerificationId;
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          title: 'Invalid Phone Number'.centerText,
          titlePadding: const EdgeInsets.all(16),
          actions: ['Cancel', 'Retry']
              .map(
                (e) => TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: e.plainText,
                ),
              )
              .toList(),
        ),
      );
      return;
    }
  }

  Future<void> validateOtp() async {
    FocusManager.instance.primaryFocus?.unfocus();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: otp!,
    );
    UserCredential userCredential =
        await AuthController.auth.signInWithCredential(credential);
    if (userCredential.user != null) {
      if (!mounted) return;
      AuthController.registrationNavigation(context, userCredential);
    }
  }

  void showSnackBar(String message, {bool isError = false}) async =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: message.plainText,
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        ),
      );
}
