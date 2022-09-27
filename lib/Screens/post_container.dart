import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:jatayu/modals/Post.dart';
import '../Theme.dart';
import '../Widgets/alert_dialog.dart';
import '../database/network_database.dart';
import 'IndividualPost.dart';

class PostContainer extends StatelessWidget {
  final Post thisPost;
  final bool isOwnPost;
  final Function? onDeleteFunction;
  PostContainer({
    Key? key,
    required this.thisPost,
    this.isOwnPost = false,
    this.onDeleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
          Style.navigateBack(
            context,
            IndividualPost(
              thisPost: thisPost,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isOwnPost)
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (builder) => CustomAlertDialog(
                        context: context,
                        title: 'Confirm Delete',
                        columnWidgets: [
                          'Once you delete the post, it cannot be undone'
                              .plainText,
                        ],
                        primaryButton: 'Confirm',
                        secondaryButton: 'Cancel',
                        onDone: () async {
                          Style.loadingDialog(
                            context,
                            title: 'Deleting post',
                          );
                          await Network.deletePost(
                            thisPost.postID!,
                            thisPost.postUrls,
                          );

                          if (onDeleteFunction != null) onDeleteFunction!();
                          // remove the showLoading
                          Navigator.pop(context);

                          // remove the custom alert dialog
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade400,
                    size: 18,
                  ),
                  label: Text(
                    'Delete Post',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.red.shade400,
                        ),
                  ),
                ),
              ),
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
            if (thisPost.postUrls != null) imageSlideShowWidget(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                thisPost.description ?? '',
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Hero(
                    tag: thisPost.postID.toString(),
                    child: PostUserContainer(thisPost),
                  ),
                  //TODO: USE CUSTOM FUTURE BUILDER HERE

                  8.height,
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
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            const Divider(),

            postButtons(),
            8.height,
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
  }

  Padding postButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PostButton(
            iconData: Icons.favorite_border,
            label: 'Like',
            onTap: () => print('Like'),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: PostButton(
              iconData: Icons.insert_comment_rounded,
              label: 'Comment',
              onTap: () => print('Comment'),
            ),
          ),
          PostButton(
            iconData: Icons.share_rounded,
            label: 'Share',
            onTap: () => print('Share'),
          )
        ],
      ),
    );
  }

  Container imageSlideShowWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(context).size.height / 1.64,
      //   maxWidth: MediaQuery.of(context).size.width,
      // ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: ImageSlideshow(
        initialPage: 0,
        indicatorColor: Colors.blue,
        indicatorBackgroundColor: Colors.grey,
        children: thisPost.postUrls!
            .map(
              (e) => CachedNetworkImage(
                imageUrl: e,
              ),
            )
            .toList(),
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function onTap;

  const PostButton({
    Key? key,
    required this.iconData,
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
            Icon(
              // MdiIcons.shareOutline,
              iconData,
              color: Style.lightText.withOpacity(0.87),
              size: 18.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: Style.subtitle.copyWith(
                fontFamily: Style.fontName,
                color: Style.lightText.withOpacity(0.60),
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
  final Post post;
  const PostUserContainer(
    this.post, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('The user url is ${post.userUrl}');
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
      height: MediaQuery.of(context).size.height / 5.8,
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
                  post.userNameWithClass ?? '',
                  style: Style.title.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Style.nearlyDarkBlue,
                  ),
                ),
                Text(
                  '${post.dateTime!.month.toString().padLeft(2, '0')} | ${post.dateTime!.day.toString().padLeft(2, '0')}',
                  style: Style.subtitle.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Style.nearlyDarkBlue.withOpacity(0.62),
                  ),
                ),
                Text(
                  post.schoolName ?? '',
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
          8.width,
          Expanded(
            child: CircleAvatar(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(post.userUrl ?? ''),
              maxRadius: 48,
              minRadius: 40,
            ),
          ),
        ],
      ),
    );
  }
}
