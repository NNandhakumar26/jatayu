import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jatayu/Theme.dart';
import 'package:jatayu/about/profile_page.dart';
import 'package:jatayu/registration_login/services/validators.dart';
import '../../Controllers/MainpageContoller.dart';
import '../../Screens/homePage.dart';
import '../../Widgets/alert_dialog.dart';
import '../../Widgets/image_picker.dart';
import '../services/auth_controller.dart';
import '../widgets/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  bool isRegistrationPage = false;
  String? loginId;
  String? password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Log in",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(
                  height: 70,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => loginId = value,
                  autocorrect: false,
                  validator: (value) => Validators.isValidEmail(value)
                      ? null
                      : 'Enter a valid Mail ID',
                  decoration: InputDecoration(
                    labelText: "Email ID",
                  ),
                ),
                30.height,
                TextFormField(
                  // initialValue: password,
                  obscureText: obscureText,
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) => Validators.isNotNull(value)
                      ? null
                      : 'Value cannot be empty',
                  decoration: InputDecoration(
                    labelText: 'Your password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                30.height,
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!(formKey.currentState!.validate())) return;
                      Style.loadingDialog(context, title: 'Hold on a while');
                      String? response =
                          await AuthController.signInUser(loginId!, password!);
                      if (!mounted) return;
                      Navigator.pop(context);
                      if (response is String) {
                        if (response == 'New User') {
                          await AuthController.createUser(
                            userEmail: loginId!,
                            password: password!,
                          );
                          if (!mounted) return;
                          Style.navigate(
                            context,
                            ProfilePage(
                              isNewUser: true,
                              emailAddress: loginId,
                              password: password,
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (builder) => CustomAlertDialog(
                              context: context,
                              title: 'Error',
                              columnWidgets: [
                                response.plainText,
                              ],
                              primaryButton: 'Retry',
                              secondaryButton: 'Cancel',
                            ),
                          );
                        }
                      } else {
                        if (!mounted) return;
                        Get.lazyPut<MainPageController>(
                          () => MainPageController(),
                        );
                        Style.navigate(context, HomePage());
                      }
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       (isRegistrationPage)
                //           ? "Already have an account - ".centerText
                //           : "Don\'t Have an account - ".centerText,
                //       TextButton(
                //         onPressed: () {
                //           setState(() {
                //             isRegistrationPage = !isRegistrationPage;
                //           });
                //         },
                //         // highlightColor: Colors.black,
                //         // shape: StadiumBorder(),
                //         child: Text(
                //           (isRegistrationPage) ? "Sign in" : 'Sign up',
                //           style: TextStyle(
                //             color: Colors.grey,
                //             fontSize: 17,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                48.height,
                SignInOptionsWidget(),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
