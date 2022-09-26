import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jatayu/modals/Post.dart';
import 'package:jatayu/Widgets/bouncingButton.dart';

import '../Theme.dart';

class PostCreationPage extends StatefulWidget {
  PostCreationPage({Key? key}) : super(key: key);

  @override
  State<PostCreationPage> createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  final newPost = Post();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<XFile>? images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBar(),
        // child: CompanyAppbar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichTextField(
                  title: 'Title',
                  icon: Icons.description_rounded,
                  multiLine: 2,
                  onChanged: (value) {
                    newPost.postTitle = value;
                  },
                ),
                RichTextField(
                  title: 'Caption',
                  icon: Icons.description_rounded,
                  multiLine: 5,
                  onChanged: (value) {
                    newPost.description = value;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Upload your file',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 20,
                        color: Style.nearlyDarkBlue,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'File should be jpg, png',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: selectFile,
                  child: Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Style.nearlyDarkBlue.withOpacity(0.32),
                        width: 0.6,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open_rounded,
                          color: Style.nearlyDarkBlue.withOpacity(0.72),
                          size: 40,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Select your file',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 13,
                                    color: Colors.grey.shade400,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                (images!.isNotEmpty)
                    ? Column(
                        children: [
                          ...images!
                              .map(
                                (file) => Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Selected File',
                                            style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 15,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              images!.remove(file);
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.delete_forever,
                                              color:
                                                  Style.nearlyBlack.withOpacity(
                                                0.87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              spreadRadius: 2,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                File(file.path),
                                                width: 70,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    file.name,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'file.length()',
                                                    // '${(File(file.path). / 1024).ceil()} KB',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors
                                                            .grey.shade500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 5,
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.blue.shade50,
                                                    ),
                                                    child: LinearProgressIndicator(
                                                        // value: loadingController.value,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 150,
                ),
                BouncingButton(
                  voidCallback: () async {
                    // showDialog(
                    //   context: context,
                    //   builder: (_) => CustomAlertDialog(
                    //     context: context,
                    //     title: 'Please Wait',
                    //     columnWidgets: [],
                    //   ),
                    // );
                    //TODO: UPDATE THE IMAGES TO THE DATABASE...
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(),
                      ),
                    );
                  },
                  title: 'Upload',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectFile() async {
    final ImagePicker _picker = ImagePicker();
    await _picker.pickMultiImage().then((value) {
      if (value != null) {
        images!.addAll(value.toList());
        value.length;
      }
    });
    setState(() {});
  }
}

class RichTextField extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;
  final Widget? widget;
  final int? multiLine;
  final Function? onChanged;

  RichTextField({
    required this.title,
    this.value,
    this.icon,
    this.widget,
    this.multiLine = 1,
    this.onChanged,
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
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Icon(
                icon,
                size: 18,
                color: Style.nearlyDarkBlue.withOpacity(0.60),
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
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Style.nearlyDarkBlue.withOpacity(0.87),
                        ),
                  ),
                ),
                (widget == null)
                    ? Container(
                        margin: EdgeInsets.only(
                          top: 4,
                          right: 8,
                        ),
                        padding: EdgeInsets.all(2),
                        child: TextField(
                          // decoration: Style.inputFieldDecorationWithoutLabel(
                          //   title: title,
                          // ),
                          maxLines: multiLine,
                          onChanged: (String text) {
                            if (onChanged != null) {
                              onChanged!(text);
                            }
                          },
                          style: Style.subtitle.copyWith(
                            color: Style.nearlyDarkBlue,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w700,
                          ),
                        ))
                    : widget!,
              ],
            ),
          )
        ],
      ),
    );
  }
}
