import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/About_Section/aboutController.dart';
import 'package:jatayu/Screens/mainpage.dart';
import 'package:jatayu/Widgets/bouncingButton.dart';

import '../Theme.dart';

class ProfilePage extends GetView<AboutController> {
  final purpleColor = Color(0xff6688FF);
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final textFieldColor = Color(0xffF5F6FA);
  final borderColor = Color(0xffD9D9D9);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Style.nearlyDarkBlue.withOpacity(0.60),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Profile Page',
          style: Style.headline.copyWith(
            color: Style.nearlyDarkBlue.withOpacity(0.87),
            letterSpacing: -0.4,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 4,
        shadowColor: Colors.black26,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(height: 24),
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      // ImageSelectionBottomSheet(context);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      child: (controller.imageUrl == null)
                          ? FlutterLogo(
                              size: 60,
                            )
                          : Container(
                              height: 150,
                              width: 150,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    controller.imageUrl.value.toString(),
                                  ),
                                ),
                              ),
                              // child: Image.file(
                              //     c.file,
                              //     fit: BoxFit.cover,
                              //     height: 150,
                              //     width: 150,
                              //   ),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 2,
                    child: GestureDetector(
                      onTap: () {
                        // ImageSelectionBottomSheet(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.87),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Style.nearlyDarkBlue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Center(
            //   child: Stack(
            //     children: [
            //       buildImage(),
            //       Positioned(
            //         bottom: 0,
            //         right: 4,
            //         child: buildEditIcon(Style.nearlyDarkBlue),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 32),
            RichTextField(
              title: 'Name',
              icon: Icons.person_add,
              initialValue: controller.thisUser.name ?? '',
              onChanged: (value) {
                controller.thisUser.name = value;
              },
            ),
            RichTextField(
              title: 'Participant ID',
              icon: Icons.perm_identity,
              initialValue: controller.thisUser.userID ?? '',
              onChanged: (value) {
                controller.thisUser.userID = value;
              },
            ),
            RichTextField(
              title: 'Mobile Number',
              icon: Icons.phone_android_rounded,
              initialValue: (controller.thisUser.phoneNumber != null)
                  ? controller.thisUser.phoneNumber.toString()
                  : '',
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  controller.thisUser.phoneNumber = int.tryParse(value);
                }
              },
            ),
            RichTextField(
              title: 'Class',
              icon: Icons.meeting_room_rounded,
              initialValue: controller.thisUser.userClass ?? '',
              onChanged: (value) {
                controller.thisUser.userClass = value;
              },
            ),
            RichTextField(
              title: 'School',
              icon: Icons.school_rounded,
              initialValue: controller.thisUser.schoolName ?? '',
              onChanged: (value) {
                controller.thisUser.schoolName = value;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: BouncingButton(
                voidCallback: () {},
                title: 'Update',
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
      ),
    ));
  }

  Widget buildImage() {
    final image = NetworkImage('imagePath');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: () {}),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  final thisStyle = Style.subtitle2.copyWith(
    color: Style.lightText,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}

class RichTextField extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;
  final Widget? widget;
  final int? multiLine;
  final Function? onChanged;
  final String? initialValue;
  final bool? isReadonly;

  RichTextField({
    required this.title,
    this.value,
    this.icon,
    this.widget,
    this.multiLine = 1,
    this.onChanged,
    this.initialValue,
    this.isReadonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: (icon == null) ? false : true,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: Icon(
                icon,
                size: 18,
                color: Style.nearlyDarkBlue.withOpacity(0.32),
              ),
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    title,
                    style: Style.headline.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Style.darkText.withOpacity(0.87),
                    ),
                  ),
                ),
                (widget == null)
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: TextFormField(
                          decoration: Style.inputFieldDecorationWithoutLabel(
                            title: title,
                          ),
                          initialValue: initialValue ?? '',
                          readOnly: isReadonly ?? false,
                          maxLines: multiLine,
                          onChanged: (String text) {
                            if (onChanged != null) {
                              onChanged!(text);
                            }
                          },
                          style: Style.body2.copyWith(
                            color: Colors.black87,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : widget!,
              ],
            ),
          )
        ],
      ),
    );
  }
}
