import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Controllers/MainpageContoller.dart';
import 'package:jatayu/Model/Post.dart';
import 'package:jatayu/Screens/post_container.dart';

import '../Theme.dart';

class IndividualPost extends GetView<MainPageController> {
  final Post thisPost;
  IndividualPost({required this.thisPost});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.background,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 4,
        shadowColor: Style.nearlyDarkBlue.withOpacity(0.08),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black54,
            size: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, right: 8, left: 8),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Style.nearlyDarkBlue,
                    width: 0.32,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Style.nearlyDarkBlue.withOpacity(0.32),
                      offset: Offset(0.8, 1.6),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: ListTile(
                  onTap: () {},
                  leading: Hero(
                    tag: thisPost.postID.toString(),
                    child: CircleAvatar(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(
                          thisPost.userDetails!.imageUrl ?? ''),
                      maxRadius: 48,
                      minRadius: 40,
                    ),
                  ),
                  isThreeLine: true,
                  dense: false,
                  title: Text(
                    thisPost.userDetails?.name ?? 'Priya Dharshini',
                    style: Style.title.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Style.nearlyDarkBlue,
                    ),
                  ),
                  subtitle: Text(
                    thisPost.userDetails?.schoolName ??
                        'St.John\'s International School, Fatehabad, Haryana.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Style.caption.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Style.lightText.withOpacity(0.87),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Style.nearlyDarkBlue,
                    width: 0.32,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //make it clickable and link this to profile page and view appropriate profile details
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        thisPost.postTitle ??
                            'One More Plant.! Extra Delight...!! ',
                        textAlign: TextAlign.center,
                        style: Style.title.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
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
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        thisPost.description ??
                            'Writing a poem is not about bringing some words together to create some charming sentences. It\'s so much deeper than that. Writing poetry is a bridge that allows people to express their feelings and make others live every single word they read. Poetry is to educate people, to lead them away from hate to love, from violence to mercy and pity. Writing poetry is to help this community better understand life and live it more passionately. PoemHunter.com contains an enormous number of famous poems from all over the world, by both classical and modern poets. You can read as many as you want, and also submit your own poems to share your writings with all our poets, members, and visitors.',
                        style: Style.title.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Style.lightText.withOpacity(0.87),
                        ),
                        // maxLines: 4,
                        // overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
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
                              '1k',
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
                    SizedBox(
                      height: 8,
                    ),

                    //DISPLAY THE LIST OF IMAGES USING LISTVIEW.BUILDER... or spread operator
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Card(
                      elevation: 8,
                      color: Colors.white70,
                      margin: EdgeInsets.all(4),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: CachedNetworkImage(
                          imageUrl: thisPost.imageUrl ?? '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
