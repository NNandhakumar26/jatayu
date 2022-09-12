import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Screens/Activities.dart';
import 'package:jatayu/Theme.dart';

import '../Model/Activity.dart';

class IndividualPage extends StatelessWidget {
  final Activity activity;
  IndividualPage(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 270,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundImage:
                              AssetImage('assets/images/jatayu.png'),
                          // child: Image.asset('assets/images/jatayu.png'),
                        ),
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 22,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.share, size: 22, color: Colors.white),
                        onPressed: () {
                          // _handleShare();
                        },
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blue[600],
                                    ),
                                    child: AnimatedPadding(
                                      duration: Duration(milliseconds: 1000),
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10, //140 or 10
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        activity.category ?? 'Category',
                                        style: Style.body1.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  // IconButton(
                                  //     icon: BuildLoveIcon(
                                  //         collectionName: 'contents',
                                  //         uid: sb.uid,
                                  //         timestamp: d.timestamp),
                                  //     onPressed: () {
                                  //       handleLoveClick();
                                  //     }),
                                  // IconButton(
                                  //     icon: BuildBookmarkIcon(
                                  //         collectionName: 'contents',
                                  //         uid: sb.uid,
                                  //         timestamp: d.timestamp),
                                  //     onPressed: () {
                                  //       handleBookmarkClick();
                                  //     },),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),

                              Text(
                                activity.title ?? '',
                                style: Style.body1.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Divider(
                                color: Style.nearlyDarkBlue.withOpacity(0.60),
                                endIndent: Get.width / 1.24,
                                thickness: 2,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    CupertinoIcons.time_solid,
                                    size: 18,
                                    color:
                                        Style.nearlyDarkBlue.withOpacity(0.60),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    activity.date ?? '32/10/2021',
                                    style: Style.subtitle2.copyWith(
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                              // d.sourceUrl == null
                              //     ? Container()

                              //CHECK THIS

                              // InkWell(
                              //   child: Container(
                              //     margin: EdgeInsets.only(top: 8, bottom: 8),
                              //     child: Chip(
                              //       backgroundColor: Colors.red,
                              //       // backgroundColor: context
                              //       //             .watch<ThemeBloc>()
                              //       //             .darkTheme ==
                              //       //         false
                              //       //     ? CustomColor()
                              //       //         .loadingColorLight
                              //       //     : CustomColor()
                              //       //         .loadingColorDark,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(5)),
                              //       materialTapTargetSize:
                              //           MaterialTapTargetSize.shrinkWrap,
                              //       label: Wrap(
                              //         alignment: WrapAlignment.center,
                              //         children: [
                              //           Icon(
                              //             // Feather.external_link,
                              //             Icons.link_rounded,
                              //             size: 16,
                              //           ),
                              //           SizedBox(
                              //             width: 5,
                              //           ),
                              //           Text(
                              //             'source',
                              //             style: TextStyle(
                              //                 fontSize: 14,
                              //                 fontWeight: FontWeight.w500),
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              //   onTap: () async {
                              //     // launchURL(context, d.sourceUrl);
                              //   },
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Row(
                              //   children: <Widget>[
                              //     Icon(
                              //       Icons.favorite,
                              //     ),
                              //     // LoveCount(
                              //     //     collectionName: 'contents',
                              //     //     timestamp: d.timestamp),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     SizedBox(
                              //       width: 6,
                              //     ),
                              //     TextButton.icon(
                              //       onPressed: () {},
                              //       style: ButtonStyle(
                              //         backgroundColor:
                              //             MaterialStateProperty.resolveWith(
                              //           (states) => Colors.green[300],
                              //         ),
                              //         shape: MaterialStateProperty.resolveWith(
                              //           (states) => RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(3),
                              //           ),
                              //         ),
                              //       ),
                              //       icon: Icon(
                              //         Icons.comment,
                              //         color: Colors.black87,
                              //         size: 20,
                              //       ),
                              //       label: Text(
                              //         'comments',
                              //         style: TextStyle(
                              //           color: Colors.black87,
                              //         ),
                              //       ),
                              //       // onPressed: () {
                              //       //   //disposeAdmobbanner(); //admob
                              //       //   nextScreen(context,
                              //       //       CommentsPage(timestamp: d.timestamp));
                              //       // },
                              //     )
                              //   ],
                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 16,
                                ),
                                child: Text(
                                  activity.desc ?? '',
                                  style: Style.body1.copyWith(
                                    color: Style.lightText,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
