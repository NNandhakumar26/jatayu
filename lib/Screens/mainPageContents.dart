import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Model/Post.dart';
import 'package:jatayu/Network/data_fetching.dart';
import 'package:jatayu/Screens/custom_future_builder.dart';
import 'package:jatayu/Screens/post_container.dart';
import 'package:jatayu/Widgets/image_picker.dart';
import '../Theme.dart';
import 'Activities.dart';

class MainpageContainer extends StatefulWidget {
  const MainpageContainer({Key? key}) : super(key: key);

  @override
  State<MainpageContainer> createState() => _MainpageContainerState();
}

class _MainpageContainerState extends State<MainpageContainer> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          CustomPostContainer(),
          SizedBox(
            height: 8,
          ),
          Container(
            height: Get.height / 3.2,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Activities(),
          ),
          CustomFutureBuilder<List<Post>>(
            onSuccessWidget: (data) => Column(
              children: data
                  .map(
                    (e) => PostContainer(
                      thisPost: e,
                    ),
                  )
                  .toList(),
            ),
            futureFunction: Network.getAllPosts(),
          )
        ],
      ),
    );
  }
}

class CustomPostContainer extends StatefulWidget {
  CustomPostContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomPostContainer> createState() => _CustomPostContainerState();
}

class _CustomPostContainerState extends State<CustomPostContainer> {
  final commentController = TextEditingController();

  final _image = <File?>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height / 4.8,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Style.nearlyDarkBlue,
          width: 0.3,
        ),
        boxShadow: [
          BoxShadow(
            color: Style.darkText.withOpacity(0.18),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0.98, 1.6),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 24,
                    foregroundImage: AssetImage('assets/images/DP.jpg'),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 4,
                child: TextFormField(
                  // controller: controller.lastNameTextEditController.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a Valid Last Name';
                    }
                    return null;
                  },
                  autofocus: false,
                  textInputAction: TextInputAction.next, maxLines: 3,
                  style: Style.subtitle.copyWith(
                    color: Style.darkerText.withOpacity(0.87),
                    letterSpacing: 0.2,
                  ),
                  cursorColor: Style.nearlyDarkBlue.withOpacity(0.87),
                  decoration: Style.decoration,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          const Divider(height: 10.0, thickness: 0.5),
          SizedBox(
            height: 2,
          ),
          // add the button to photos and post button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => GetImageWidget(),
                      ).then(
                        (value) {
                          if (value != null) {
                            setState(
                              () {
                                _image.addAll(value);
                              },
                            );
                          }
                        },
                      );
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor: MaterialStateProperty.all(
                        Style.notWhite,
                      ),
                    ),
                    child: Icon(
                      Icons.photo_library_sharp,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Spacer(),
              const VerticalDivider(
                width: 8.0,
                thickness: 20.0,
                color: Colors.black,
              ),
              Spacer(),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(2),
                    backgroundColor: MaterialStateProperty.all(
                      Style.nearlyDarkBlue.withOpacity(0.87),
                    ),
                  ),
                  child: Text(
                    'Post',
                    style: Style.title.copyWith(
                      color: Colors.white.withOpacity(0.87),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ..._image
              .map(
                (imageFile) => ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.32,
                    ),
                  ),
                  leading: CircleAvatar(
                    foregroundImage: FileImage(imageFile!),
                  ),
                  title: Text(
                    'Image ${_image.indexOf(imageFile) + 1}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _image.remove(imageFile);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade600.withOpacity(0.87),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
