import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jatayu/Theme.dart';
import 'package:jatayu/Widgets/appbars.dart';
import 'package:jatayu/modals/User.dart';

import '../Widgets/alert_dialog.dart';
import '../database/network_database.dart';
import '../modals/Post.dart';
import '../registration_login/services/auth_controller.dart';
import '../widgets/image_picker.dart';

class PostCreationPage extends StatefulWidget {
  @override
  State<PostCreationPage> createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  final commentController = TextEditingController();
  final titleController = TextEditingController();

  User? user = AuthController().user;
  Post post = Post();

  final files = <File?>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: DefaultAppbar(title: 'Post Creation Page'),
        preferredSize: Size(
          double.infinity,
          60,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: titleController,
                autofocus: true,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                decoration: InputDecoration(
                  hintText: 'Title to your post',
                  hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey.withOpacity(0.60),
                      ),
                ),
              ),
            ),
            12.height,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: commentController,
                autofocus: false,
                textInputAction: TextInputAction.next,
                maxLines: 4,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    // fontWeight: FontWeight.bold,
                    // fontSize: 16,
                    ),
                decoration: InputDecoration(
                  hintText: 'Write down your comments here...',
                  hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey.withOpacity(0.60),
                      ),
                ),
              ),
            ),

            16.height,
            // add the button to photos and post button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await showDialog<List<File>?>(
                        context: context,
                        builder: (context) => GetImageWidget(),
                      ).then(
                        (returnFiles) {
                          if (returnFiles != null) {
                            setState(
                              () {
                                files.addAll(returnFiles);
                              },
                            );
                          }
                        },
                      );
                    },
                    label: 'Attach Images'.plainText,
                    icon: Icon(
                      Icons.image_search_rounded,
                      size: 18,
                    ),
                  ),
                ),
                // Spacer(),
                // const VerticalDivider(
                //   width: 8.0,
                //   thickness: 20.0,
                //   color: Colors.black,
                // ),
              ],
            ),
            // TODO:start from here
            Expanded(
              child: Wrap(
                children: files
                    .map(
                      (imageFile) => fileDisplayWidget(
                        context,
                        imageFile,
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (((files.isEmpty) && (commentController.text.isEmpty)) ||
              (titleController.text.isEmpty)) {
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomAlertDialog(
                context: context,
                title: 'Post cannot be empty',
                columnWidgets: [
                  if (titleController.text.isEmpty)
                    'The title cannot be empty'.plainText,
                  'Either the file or the comment should be not empty'
                      .plainText,
                ],
              ),
            );
            return;
          }
          Style.loadingDialog(context, title: 'Uploading post');

          AppUser appUser = await Network.getUserWithID(user!.uid);
          post.postTitle = titleController.text;
          if (commentController.text.isNotEmpty) {
            post.description = commentController.text;
          }
          if (files.isNotEmpty) await uploadFiles();
          post.dateTime = DateTime.now();
          post.userID = user!.uid;
          post.userNameWithClass = '${appUser.name} - ${appUser.userClass}';
          post.schoolName = appUser.schoolName;
          post.userUrl = appUser.imageUrl;

          await Network.createPost(post);

          // Remove the dialog
          Navigator.pop(context);

          // Go back to the main page
          Navigator.pop(context);
          return;
        },
        extendedPadding: EdgeInsets.symmetric(horizontal: 24),
        icon: Icon(
          Icons.send,
          size: 18,
        ),
        label: Text(
          'Post',
          // style: Theme.of(context).textTheme.headline6s,
        ),
      ),
    );
  }

  Widget fileDisplayWidget(BuildContext context, File? imageFile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: Colors.black38,
          width: 0.6,
        ),
      ),
      height: MediaQuery.of(context).size.width / 2.4,
      width: MediaQuery.of(context).size.width / 2.4,
      margin: EdgeInsets.all(6),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4,
      ),

      child: GridTile(
        child: Stack(
          children: [
            Image(
              image: FileImage(
                imageFile!,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  files.remove(imageFile);
                  setState(() {});
                },
                icon: Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      // child: ListTile(
      //   shape: RoundedRectangleBorder(
      //     side: BorderSide(color: Colors.black, width: 1),
      //     borderRadius: BorderRadius.circular(5),
      //   ),
      //   leading: CircleAvatar(
      //     foregroundImage: FileImage(imageFile!),
      //   ),
      //   title: Text(
      //     'Image ${files.indexOf(imageFile) + 1}',
      //   ),
      //   trailing: IconButton(
      //     onPressed: () {
      //       files.remove(imageFile);
      //       setState(() {});
      //     },
      //     icon: Icon(
      //       Icons.delete,
      //       color: Colors.red.shade600.withOpacity(0.87),
      //     ),
      //   ),
      // ),
    );
  }

  Future<void> uploadFiles() async {
    if (files.isEmpty) return;

    for (var file in files) {
      if (file == null) continue;
      String url = await Network.uploadFile(
        file: file,
        isPost: true,
      );
      post.postUrls ??= [];
      post.postUrls!.add(url);
    }
  }
}
