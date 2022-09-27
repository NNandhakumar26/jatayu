import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Widgets/bouncingButton.dart';
import 'package:jatayu/Widgets/loading_dialog.dart';
import 'package:jatayu/database/network_database.dart';
import 'package:jatayu/modals/User.dart';
import '../Controllers/MainpageContoller.dart';
import '../Screens/homePage.dart';
import '../Theme.dart';
import '../Widgets/appbars.dart';
import '../Widgets/image_picker.dart';
import '../registration_login/services/auth_controller.dart';
import '../registration_login/services/validators.dart';

class ProfilePage extends StatefulWidget {
  final bool isNewUser;
  final String? emailAddress;
  final String? password;
  final String? phoneNumber;

  ProfilePage({
    this.isNewUser = false,
    this.emailAddress,
    this.password,
    this.phoneNumber,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<AppUser> appUser;

  @override
  void initState() {
    super.initState();
    appUser = (widget.isNewUser)
        ? Future.value(
            AppUser(
              emailAddress: widget.emailAddress,
              phoneNumber: widget.phoneNumber,
            ),
          )
        : Network.getUserWithID(FirebaseAuth.instance.currentUser!.uid);
  }

  InputDecoration inputDecoration(String title, IconData iconData) {
    return InputDecoration(
      hintText: title,
      icon: Icon(
        iconData,
        size: 20,
        color: Colors.grey.shade400,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          child: DefaultAppbar(
            title: 'Profile Page',
          ),
          preferredSize: Size(double.infinity, 60),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder<AppUser>(
            future: appUser,
            builder: (context, value) {
              print('the value of value is ${value.data}');
              AppUser appUser = (value.data == null) ? AppUser() : value.data!;
              return (value.connectionState == ConnectionState.done)
                  ? Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          SizedBox(height: 24),
                          displayImageWidget(context, appUser),

                          SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration:
                                  inputDecoration('Name', Icons.person_add),
                              initialValue: appUser.name ?? '',
                              validator: (value) => Validators.isNotNull(value)
                                  ? null
                                  : 'Value cannot be empty',
                              onChanged: (value) {
                                appUser.name = value;
                              },
                            ),
                          ),
                          // TextFormField(
                          //  decoration: inputDecoration('Name', Icons.person_add), 'Participant ID',
                          //   icon: Icons.perm_identity,
                          //   initialValue: controller.thisUser.userID ?? '',
                          //   onChanged: (value) {
                          //     controller.thisUser.userID = value;
                          //   },
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: inputDecoration('Contact Number',
                                  Icons.phone_android_rounded),
                              validator: (value) => (value!.isNotEmpty)
                                  ? Validators.isValidPhoneNumber(value)
                                      ? null
                                      : 'Invalid Phone Number'
                                  : null,
                              initialValue: appUser.phoneNumber ?? '',
                              onChanged: (value) {
                                if (int.tryParse(value) != null) {
                                  appUser.phoneNumber = value;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: inputDecoration(
                                  'Class', Icons.meeting_room_rounded),
                              initialValue: appUser.userClass ?? '',
                              validator: (value) => Validators.isNotNull(value)
                                  ? null
                                  : 'Cannot be Empty',
                              onChanged: (value) {
                                appUser.userClass = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: inputDecoration(
                                  'School Name', Icons.school_rounded),
                              validator: (value) => Validators.isNotNull(value)
                                  ? null
                                  : 'Cannot be Empty',
                              initialValue: appUser.schoolName ?? '',
                              onChanged: (value) {
                                appUser.schoolName = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 32),
                            child: BouncingButton(
                              voidCallback: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  Style.loadingDialog(
                                    context,
                                    title: 'Updating info',
                                  );
                                  await updateDetailsToDatabase(appUser);

                                  // ** Remove The Popup **
                                  Navigator.of(context).pop();

                                  // ** Remove the main screen **
                                  // if (!context.mounted) return;

                                  if (widget.isNewUser) {
                                    Get.lazyPut<MainPageController>(
                                      () => MainPageController(),
                                    );
                                    Style.navigate(context, HomePage());
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  return;
                                }
                              },
                              title: (widget.isNewUser) ? 'Submit' : 'Update',
                            ),
                            // child: ElevatedButton(
                            //   style: ButtonStyle(
                            //     padding: MaterialStateProperty.all(
                            //         EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
                            //     backgroundColor: MaterialStateProperty.all(
                            //       Style.lightText,
                            //     ),
                            //   ),
                            //   onPressed: () {},
                            //   child: Text(
                            //     'Submit',
                            //     style: Style.subtitle.copyWith(
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 16,
                            //       letterSpacing: 0.8,
                            //       color: Style.white.withOpacity(0.87),
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    )
                  : CustomLoadingDialog(
                      title: 'Loading info',
                    );
            },
          ),
        ),
      ),
    );
  }

  Future<void> updateDetailsToDatabase(AppUser appuser) async {
    User? user = AuthController().user!;
    await user.updateDisplayName(appuser.name!);

    user = FirebaseAuth.instance.currentUser!;
    print(FirebaseAuth.instance.currentUser!.uid.toString());
    AppUser thisUser = appuser.copyWith(
      name: user.displayName,
      imageUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
      userID: FirebaseAuth.instance.currentUser!.uid,
      emailAddress: user.email,
    );
    await Network.updateUser(thisUser)
        .then((value) => print('Done uploading user'));
    return;
  }

  Widget displayImageWidget(BuildContext context, AppUser appUser) {
    print('Entered into the new image widget');
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: scaffoldKey.currentContext!,
                builder: (context) => GetImageWidget(),
              ).then(
                (imageFile) {
                  if (imageFile != null) {
                    Style.loadingDialog(context, title: 'Uploading image');

                    Network.uploadFile(
                      isPost: false,
                      file: imageFile[0],
                      updateFileUrl:
                          FirebaseAuth.instance.currentUser?.photoURL ?? '',
                    ).then(
                      (imageUrl) async {
                        appUser.imageUrl = imageUrl;
                        print('Done');

                        await FirebaseAuth.instance.currentUser!
                            .updatePhotoURL(imageUrl)
                            .then(
                              (value) =>
                                  Navigator.pop(scaffoldKey.currentContext!),
                            );
                        await Network.updateUser(appUser);
                        print('Done 2');
                        setState(() {});
                        return;
                      },
                    );
                  }
                },
              );
            },
            child: CircleAvatar(
              radius: 72,
              child: (FirebaseAuth.instance.currentUser!.photoURL == null)
                  ? const FlutterLogo(
                      size: 60,
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      foregroundImage: CachedNetworkImageProvider(
                        appUser.imageUrl!,
                      ),
                      // height: 150,
                      // width: 150,
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.circle,
                      // ),
                      // child: CachedNetworkImage(
                      //   imageUrl:
                      //       FirebaseAuth.instance.currentUser!.photoURL!,
                      // ),
                    ),
            ),
          ),
          Positioned(
            right: 4,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.87),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                size: 16,
                color: Colors.blue.shade700,
              ),
            ),
          )
        ],
      ),
    );
  }

  final thisStyle = Style.subtitle2.copyWith(
    color: Style.lightText,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}

// class TextFormField extends StatelessWidget {
//   final String title;
//   final String? value;
//   final IconData? icon;
//   final Widget? widget;
//   final int? multiLine;
//   final Function? onChanged;
//   final String? initialValue;
//   final bool? isReadonly;

//   TextFormField({
//     required this.title,
//     this.value,
//     this.icon,
//     this.widget,
//     this.multiLine = 1,
//     this.onChanged,
//     this.initialValue,
//     this.isReadonly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Visibility(
//             visible: (icon == null) ? false : true,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
//               child: Icon(
//                 icon,
//                 size: 18,
//                 color: Style.nearlyDarkBlue.withOpacity(0.32),
//               ),
//             ),
//           ),
//           Flexible(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Text(
//                     title,
//                     style: Style.headline.copyWith(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Style.darkText.withOpacity(0.87),
//                     ),
//                   ),
//                 ),
//                 (widget == null)
//                     ? Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 4, vertical: 6),
//                         child: TextFormField(
//                           decoration: Style.inputFieldDecorationWithoutLabel(
//                            decoration: inputDecoration('Name', Icons.person_add), title,
//                           ),
//                           initialValue: initialValue ?? '',
//                           readOnly: isReadonly ?? false,
//                           maxLines: multiLine,
//                           onChanged: (String text) {
//                             if (onChanged != null) {
//                               onChanged!(text);
//                             }
//                           },
//                           style: Style.body2.copyWith(
//                             color: Colors.black87,
//                             letterSpacing: 0.4,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       )
//                     : widget!,
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
