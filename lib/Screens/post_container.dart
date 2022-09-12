import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Model/Post.dart';
import 'package:jatayu/Model/User.dart';
import 'package:jatayu/Network/data_fetching.dart';
import 'package:jatayu/Screens/custom_future_builder.dart';
import '../Theme.dart';
import 'IndividualPost.dart';

class PostContainer extends StatelessWidget {
  final Post thisPost;
  PostContainer({Key? key, required this.thisPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<AppUser>(
        futureFunction: Network.getUserWithID(thisPost.userID!),
        onSuccessWidget: (user) {
          thisPost.userDetails = user;
          return Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.50),
              border: Border.all(
                color: Style.nearlyDarkBlue,
                width: 0.3,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: InkWell(
              onTap: () {
                Get.to(
                  IndividualPost(
                    thisPost: thisPost,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      thisPost.postTitle ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: Style.headline.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        fontSize: 20,
                        color: Style.darkText.withOpacity(0.87),
                        shadows: [
                          Shadow(
                            color: Style.nearlyDarkBlue.withOpacity(0.16),
                            blurRadius: 0.8,
                            offset: Offset(0.87, 1.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    constraints: BoxConstraints(
                        maxHeight: 240, maxWidth: double.infinity / 0.80),
                    child: Material(
                      elevation: 8,
                      child: Image.network(thisPost.imageUrl ?? ''),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Style.nearlyDarkBlue.withOpacity(0.60),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.thumb_up,
                            size: 10.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            // '${post.likes}',
                            (thisPost.likes != null)
                                ? thisPost.likes.toString()
                                : '0',
                            style: Style.subtitle.copyWith(
                              // color: Colors.grey[600],
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 0.0,
                              color: Style.darkText.withOpacity(0.87),
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '12',
                            style: Style.subtitle.copyWith(
                              // color: Colors.grey[600],
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: Style.darkText.withOpacity(0.87),
                            ),
                            children: [
                              TextSpan(
                                text: ' Comments',
                                style: Style.subtitle.copyWith(
                                  // color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Style.darkText.withOpacity(0.60),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        RichText(
                          text: TextSpan(
                            text: '24',
                            style: Style.subtitle.copyWith(
                              // color: Colors.grey[600],
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: Style.darkText.withOpacity(0.87),
                            ),
                            children: [
                              TextSpan(
                                text: ' Shares',
                                style: Style.subtitle.copyWith(
                                  // color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Style.darkText.withOpacity(0.60),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            thisPost.description ??
                                'In every walk with nature one receives far more than he seeks...',
                            style: Style.title.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Style.darkText.withOpacity(0.60),
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),

                        SizedBox(
                          height: 16,
                        ),
                        Hero(
                          tag: thisPost.postID.toString(),
                          child: PostUserContainer(
                            thisUser: user,
                          ),
                        ),
                        //TODO: USE CUSTOM FUTURE BUILDER HERE
                        // if (thisPost.userID != null)
                        //   CustomFutureBuilder<AppUser>(
                        //     onSuccessWidget: (user) {
                        //       thisPost.userDetails = user;
                        //       return Hero(
                        //         tag: thisPost.postID.toString(),
                        //         child: PostUserContainer(
                        //           thisUser: user,
                        //         ),
                        //       );
                        //     },
                        //     futureFunction:
                        //         Network.getUserWithID(thisPost.userID!),
                        //   ),

                        SizedBox(
                          height: 8,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Container(
                        //       // height: 150,
                        //       width: Get.width / 2,
                        //       child: TextFormField(
                        //         // controller: controller.lastNameTextEditController.value,
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Enter a Valid Last Name';
                        //           }
                        //           return null;
                        //         },
                        //         autofocus: false,
                        //         textInputAction: TextInputAction.next, maxLines: 3,
                        //         style: Style.subtitle.copyWith(
                        //           color: Style.darkerText.withOpacity(0.87),
                        //           letterSpacing: 0.2,
                        //         ),
                        //         cursorColor: Style.nearlyDarkBlue.withOpacity(0.87),
                        //         decoration: Style.decoration,
                        //       ),
                        //     ),
                        //     Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             IconButton(
                        //               onPressed: () {},
                        //               icon: Icon(
                        //                 Icons.favorite_outline,
                        //                 color: Colors.red.withOpacity(0.87),
                        //               ),
                        //             ),
                        //             IconButton(
                        //               onPressed: () {},
                        //               icon: Icon(
                        //                 Icons.send_sharp,
                        //                 color: Colors.green.withOpacity(0.87),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         ElevatedButton(
                        //           onPressed: () {},
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStateProperty.all(
                        //               Style.nearlyDarkBlue.withOpacity(0.60),
                        //             ),
                        //           ),
                        //           child: Text('Comment'),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),

                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PostButton(
                                icon: Icon(
                                  // MdiIcons
                                  // .thumbUpOutline,
                                  Icons.thumb_up_alt_rounded,
                                  color: Colors.grey[600],
                                  size: 20.0,
                                ),
                                label: 'Like',
                                onTap: () => print('Like'),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: PostButton(
                                  icon: Icon(
                                    // MdiIcons.commentOutline,
                                    Icons.insert_comment_rounded,
                                    color: Colors.grey[600],
                                    size: 20.0,
                                  ),
                                  label: 'Comment',
                                  onTap: () => print('Comment'),
                                ),
                              ),
                              PostButton(
                                icon: Icon(
                                  // MdiIcons.shareOutline,
                                  Icons.share_rounded,
                                  color: Colors.grey[600],
                                  size: 20.0,
                                ),
                                label: 'Share',
                                onTap: () => print('Share'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 4),
                  //   width: Get.width,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       OutlinedButton.icon(
                  //         style: ButtonStyle(
                  //           padding: MaterialStateProperty.all(
                  //             EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  //           ),
                  //           foregroundColor: MaterialStateProperty.all(
                  //             Style.nearlyDarkBlue.withOpacity(0.60),
                  //           ),
                  //         ),
                  //         onPressed: () {},
                  //         icon: Icon(Icons.thumb_up_alt),
                  //         label: Text(
                  //           'Like',
                  //           style: Style.title.copyWith(
                  //             color: Style.nearlyDarkBlue.withOpacity(0.87),
                  //             letterSpacing: 0.8,
                  //           ),
                  //         ),
                  //       ),
                  //       OutlinedButton.icon(
                  //         style: ButtonStyle(
                  //           foregroundColor: MaterialStateProperty.all(
                  //             Style.darkText.withOpacity(0.60),
                  //           ),
                  //         ),
                  //         onPressed: () {},
                  //         icon: Icon(Icons.send_sharp),
                  //         label: Text(
                  //           'Share',
                  //           style: Style.title.copyWith(
                  //             color: Style.darkText.withOpacity(0.70),
                  //             letterSpacing: 0.8,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  //   width: Get.width,
                  //   // color: Colors.red,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     children: [
                  //       Container(
                  //         // height: 150,
                  //         width: Get.width / 2,
                  //         child: TextFormField(
                  //           // controller: controller.lastNameTextEditController.value,
                  //           validator: (value) {
                  //             if (value!.isEmpty) {
                  //               return 'Enter a Valid Last Name';
                  //             }
                  //             return null;
                  //           },
                  //           autofocus: false,
                  //           textInputAction: TextInputAction.next, maxLines: 3,
                  //           style: Style.subtitle.copyWith(
                  //             color: Style.darkerText.withOpacity(0.87),
                  //             letterSpacing: 0.2,
                  //           ),
                  //           cursorColor: Style.nearlyDarkBlue.withOpacity(0.87),
                  //           decoration: Style.decoration,
                  //         ),
                  //       ),
                  //       Column(
                  //         children: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               IconButton(
                  //                 onPressed: () {},
                  //                 icon: Icon(
                  //                   Icons.favorite_outline,
                  //                   color: Colors.red.withOpacity(0.87),
                  //                 ),
                  //               ),
                  //               IconButton(
                  //                 onPressed: () {},
                  //                 icon: Icon(
                  //                   Icons.send_sharp,
                  //                   color: Colors.green.withOpacity(0.87),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           ElevatedButton(
                  //             onPressed: () {},
                  //             style: ButtonStyle(
                  //               backgroundColor: MaterialStateProperty.all(
                  //                 Style.nearlyDarkBlue.withOpacity(0.60),
                  //               ),
                  //             ),
                  //             child: Text('Comment'),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          );
        });
  }
}

class PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        // height: 25.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 4.0),
            Text(
              label,
              style: Style.subtitle.copyWith(
                fontFamily: Style.fontName,
                color: Style.lightText.withOpacity(0.72),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostUserContainer extends StatelessWidget {
  final AppUser thisUser;
  const PostUserContainer({Key? key, required this.thisUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: Style.nearlyBlack.withOpacity(0.60),
          width: 0.32,
        ),
        color: Style.nearlyDarkBlue.withOpacity(0.032),
      ),
      height: Get.height / 5.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4,
                ),
                Text(
                  thisUser.name ?? 'Priya Dharshini',
                  style: Style.title.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Style.nearlyDarkBlue,
                  ),
                ),
                Text(
                  'Sept 1 | 2021',
                  style: Style.subtitle.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Style.nearlyDarkBlue.withOpacity(0.62),
                  ),
                ),
                Text(
                  thisUser.schoolName ??
                      'St.John\'s International School, Fatehabad, Haryana.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Style.caption.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Style.lightText.withOpacity(0.87),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: CircleAvatar(
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        CachedNetworkImageProvider(thisUser.imageUrl ?? ''),
                    maxRadius: 48,
                    minRadius: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
