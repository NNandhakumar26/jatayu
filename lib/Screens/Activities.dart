import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jatayu/Widgets/loading_dialog.dart';
import 'package:jatayu/modals/Activity.dart';
import 'package:jatayu/modals/User.dart';
import 'package:jatayu/database/network_database.dart';
import 'package:jatayu/Screens/IndividualActivity.dart';
import 'package:jatayu/Screens/ProfileAvatar.dart';
import 'package:get/get.dart';
import 'package:jatayu/Screens/custom_future_builder.dart';
import 'package:jatayu/Widgets/titleView.dart';
import '../Theme.dart';

class Activities extends StatelessWidget {
  final Future<List<Activity>>? futureActivityList;

  const Activities({
    Key? key,
    required this.futureActivityList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleView(
          title: 'Our Recent Activities',
        ),
        4.height,
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 6,
          ),
          child: FutureBuilder<List<Activity>>(
            future: futureActivityList,
            builder: (context, value) =>
                (value.connectionState == ConnectionState.done)
                    ? postContainer(value.data!)
                    : CustomLoadingDialog(
                        title: 'Loading',
                      ),
          ),
        ),
      ],
    );
  }

  Widget postContainer(List<Activity> value) {
    return Container(
      height: Get.height / 3.6,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 8.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: StoryCard(
              story: Activity(
                desc: value[index].desc,
                likes: value[index].likes,
                title: value[index].title,
                image: value[index].image,
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final bool isAddStory;
  final AppUser? currentUser;
  final Activity? story;

  const StoryCard({
    Key? key,
    this.isAddStory = false,
    this.currentUser,
    this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          IndividualActivity(
            thisActivity: story ?? Activity(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                child: Image(
                  height: double.infinity,
                  width: Get.width / 2.6,
                  image: CachedNetworkImageProvider(
                    story!.image!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              // child: CachedNetworkImage(
              //   // imageUrl: "http://via.placeholder.com/200x150",
              //   imageUrl: story!.imageURL!,
              //   imageBuilder: (context, imageProvider) => Container(
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: imageProvider,
              //           fit: BoxFit.cover,
              //           colorFilter:
              //               ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
              //     ),
              //   ),
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              // child: CachedNetworkImage(
              //   imageUrl: isAddStory ? currentUser!.imageUrl : story!.imageURL!,
              //   height: double.infinity,
              //   // width: 110.0,
              //   width: Get.width / 2.6,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Container(
            height: double.infinity,
            width: Get.width / 2.6,
            decoration: BoxDecoration(
              gradient: Style.storyGradient,
              borderRadius: BorderRadius.circular(12.0),
              // boxShadow: Responsive.isDesktop(context)
              //     ? const [
              //         BoxShadow(
              //           color: Colors.black26,
              //           offset: Offset(0, 2),
              //           blurRadius: 4.0,
              //         ),
              //       ]
              //     : null,
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: isAddStory
                ? Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      iconSize: 30.0,
                      color: Style.nearlyDarkBlue.withOpacity(0.87),
                      onPressed: () => print('Add to Story'),
                    ),
                  )
                : ProfileAvatar(
                    imageUrl: 'jatayu.png',
                    // hasBorder: !story!.isViewed!,
                    hasBorder: true,
                    isLocalImage: true,
                  ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: Text(
              // isAddStory ? 'Add to Story' : story!.user.name,
              //WE CAN USE THE APPROPRIATE USER NAME WHO DID SOMETHING..
              isAddStory ? 'Add to Story' : 'Jatayu Volunteer',
              style: TextStyle(
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(0.8, 1.6),
                    blurRadius: 1.4,
                  )
                ],
                color: Colors.white.withOpacity(0.87),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
