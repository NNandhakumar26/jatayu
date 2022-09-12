import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Theme.dart';

class GetImageWidget extends StatelessWidget {
  // final bool? fromGallery;
  GetImageWidget({
    Key? key,
  }) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      context: context,
      title: 'Pick Medium',
      onDone: () {},
      // noActions: true,
      columnWidgets: ['Camera', 'Gallery']
          .map(
            (e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () async {
                    List<XFile?>? image;
                    if (e == 'Camera') {
                      image!.add(
                          await _picker.pickImage(source: ImageSource.camera));
                    } else {
                      image = await _picker.pickMultiImage();
                    }

                    Navigator.pop(
                      context,
                      image!
                          .map(
                            (e) => File(e!.path),
                          )
                          .toList(),
                    );
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 0,
                  ),
                  title: Text(
                    e,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                PopupMenuDivider(
                  height: 16,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final BuildContext context;
  final String title;
  final List<Widget> columnWidgets;
  final Function? onDone;
  final String primaryButton;
  final String secondaryButton;

  CustomAlertDialog({
    required this.context,
    required this.title,
    required this.columnWidgets,
    this.onDone,
    this.primaryButton = 'Done',
    this.secondaryButton = 'Cancel',
  });
  // const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Style.nearlyDarkBlue,
              fontWeight: FontWeight.bold,
            ),
      ),
      content: Column(
        children: columnWidgets,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(16),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            secondaryButton,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Style.nearlyDarkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Style.nearlyDarkBlue.withOpacity(0.87),
            padding: EdgeInsets.all(8),
          ),
          child: Text(
            primaryButton,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white.withOpacity(0.87),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
          ),
          onPressed: () {
            if (onDone != null) {
              onDone!();
            } else
              Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
