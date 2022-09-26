import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Screens/create_post.dart';
import 'package:jatayu/modals/Activity.dart';
import 'package:jatayu/modals/Post.dart';
import 'package:jatayu/database/network_database.dart';
import 'package:jatayu/Screens/Activities.dart';
import 'package:jatayu/Screens/chat_screen.dart';
import 'package:jatayu/Screens/post_container.dart';
import 'package:jatayu/Theme.dart';

import '../Widgets/appbars.dart';
import 'MainPageContainer.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scrollController = ScrollController();
  bool zeroProducts = false;
  bool isLoadingPosts = false;
  bool hasMore = true;
  int documentLimit = 10;
  DocumentSnapshot? lastDocument;
  List<Post> postList = [];
  Future<List<Activity>> activityList = Future.value([]);

  @override
  void initState() {
    // TODO: implement initState
    initList();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 2) {
        getpostList();
      }
    });
    super.initState();
  }

  Future<void> initList() async {
    print('Entered');
    // await Future.delayed(Duration(seconds: 2));
    await getpostList();
    activityList = Network.readActivities(GetPost.activity);
    print('Exit');
  }

  getpostList() async {
    if (!hasMore) {
      return;
    }
    if (isLoadingPosts) {
      return;
    }
    setState(() {
      isLoadingPosts = true;
    });
    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      Query quary = Network.postInstance.limit(documentLimit);
      querySnapshot = await quary.get();
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          zeroProducts = true;
        });
      }
    } else {
      Query quary = Network.postInstance
          .startAfterDocument(lastDocument!)
          .limit(documentLimit);
      querySnapshot = await quary.get();
    }
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }
    if (querySnapshot.docs.isNotEmpty)
      lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    setState(
      () {
        isLoadingPosts = false;
        postList.addAll(
          querySnapshot.docs.map(
            (doc) {
              return Post.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await initList(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            const ThisPageSliverAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return createPostWidget(context);
                  }

                  return (postList.isNotEmpty)
                      ? Column(
                          children: [
                            PostContainer(
                              thisPost: postList[index - 1],
                            ),
                            if (index == postList.length) 120.height,
                            if (index == postList.length && isLoadingPosts)
                              CircularProgressIndicator(),
                          ],
                        )
                      : Container(
                          color: Colors.red,
                          height: 800,
                          width: 80,
                          child: Text('No postList'),
                        );
                },
                childCount: postList.length + 1,
              ),
            ),

            // ThisPageSliverToBoxAdapter(postList),
            // SliverList(
            //   delegate: SliverChildListDelegate(
            //     [
            //       ...postList
            //           .map(
            //             (e) => PostContainer(
            //               thisPost: e,
            //             ),
            //           )
            //           .toList(),
            //       // CustomFutureBuilder<List<Post>>(
            //       //   onSuccessWidget: (data) => Column(
            //       //     children: postList
            //       //         .map(
            //       //           (e) => PostContainer(
            //       //             thisPost: e,
            //       //           ),
            //       //         )
            //       //         .toList(),
            //       //   ),
            //       //   futureFunction: Network.getAllpostList(),
            //       // ),
            //     ],
            //   ),
            // ),

            // SliverList(
            //   delegate: SliverChildListDelegate(
            //     [
            //       Column(
            //         children: [
            //           CustomFutureBuilder<List<Post>>(
            //             onSuccessWidget: (data) => Expanded(
            //               child: ListView(
            //                 controller: _scrollController,
            //                 shrinkWrap: true,
            //                 physics: NeverScrollableScrollPhysics(),
            //                 children: data
            //                     .map(
            //                       (e) => PostContainer(
            //                         thisPost: e,
            //                       ),
            //                     )
            //                     .toList(),
            //               ),
            //             ),
            //             futureFunction: Network.getAllpostList(),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),

      // body: FirestoreListView<Post>(
      //   query: Network.postInstance.withConverter<Post>(
      //     fromFirestore: (snapshot, _) {
      //       return Post.fromMap(snapshot.data()!, snapshot.id);
      //     },
      //     toFirestore: (Post post, _) => post.toMap(),
      //   ),
      //   itemBuilder: (itemBuilder, snapshot) {
      //     Post post = snapshot.data(); // as Map<String, dynamic>;
      //     return CustomScrollView(
      //       slivers: <Widget>[
      //         const ThisPageSliverAppBar(),
      //         SliverToBoxAdapter(
      //           child: Column(
      //             children: [
      //               SizedBox(
      //                 height: 20,
      //                 child: Center(
      //                   child: const Text(
      //                     'Notification Content can be scrolled as a Text Here (can be disabled)',
      //                     style: TextStyle(fontSize: 8),
      //                   ),
      //                 ),
      //               ),
      //               CreatePostWidget(),
      //               SizedBox(
      //                 height: 8,
      //               ),
      //               Container(
      //                 height: Get.height / 3.2,
      //                 margin: EdgeInsets.symmetric(vertical: 8),
      //                 child: Activities(),
      //               ),
      //               PostContainer(thisPost: post),
      //               // ...post.entries
      //               //     .map(
      //               //       (e) => PostContainer(thisPost: e),
      //               //     )
      //               //     .toList()
      //               // CustomFutureBuilder<List<Post>>(
      //               //   onSuccessWidget: (data) => Column(
      //               //     children: data
      //               //         .map(
      //               //           (e) => PostContainer(
      //               //             thisPost: e,
      //               //           ),
      //               //         )
      //               //         .toList(),
      //               //   ),
      //               //   futureFunction: Network.getAllpostList(),
      //               // )
      //             ],
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }

  Widget createPostWidget(BuildContext context) {
    return Column(
      children: [
        8.height,
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Activities(
            futureActivityList: activityList,
          ),
        ),
        8.height,
        CustomCard(
          navigateTo: PostCreationPage(),
          title: 'Create Post',
          subtitle: 'Click to create a new post',
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget navigateTo;
  const CustomCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      borderOnForeground: true,
      color: Colors.white.withOpacity(0.90),
      shadowColor: Style.nearlyDarkBlue.withOpacity(0.32),
      child: ListTile(
        onTap: () => Style.navigateBack(
          context,
          navigateTo,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        title: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.4,
                ),
          ),
        ),
        subtitle: subtitle.subTitle,
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        ),
      ),
    );
  }
}

class ThisPageSliverAppBar extends StatelessWidget {
  const ThisPageSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: SizedBox.shrink(),
      leadingWidth: 0,
      title: CompanyAppbar(),
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: Get.height / 1.9,
      centerTitle: false,
      elevation: 8,
      //TODO: LINK AN ACTION BUTTON THE LOCATION WHERE WE CAN SEE THE DETAILS OF JATAYU
      // actions: [
      //   Icon(
      //     Icons.notifications_on_outlined,
      //     size: 12,
      //     color: Style.darkText.withOpacity(0.60),
      //   ),
      //   Icon(
      //     Icons.share,
      //     size: 12,
      //     color: Style.darkText.withOpacity(0.60),
      //   ),
      // ],
      backgroundColor: Style.background,
      shadowColor: Style.nearlyDarkBlue.withOpacity(0.32),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        // title: Row(
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       ' ',
        //       style: Style.title.copyWith(
        //         color: Style.nearlyDarkBlue.withOpacity(0.87),
        //         letterSpacing: 0.8,
        //         fontSize: 16,
        //       ),
        //     ),
        //     Expanded(
        //       flex: 5,
        //       child: SizedBox(
        //         width: 8,
        //       ),
        //     ),
        //     Expanded(
        //       flex: 1,
        //       child: Icon(
        //         Icons.notifications_on_outlined,
        //         size: 12,
        //         color: Style.darkText.withOpacity(0.60),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 1,
        //       child: Icon(
        //         Icons.share,
        //         size: 12,
        //         color: Style.darkText.withOpacity(0.60),
        //       ),
        //     ),
        //   ],
        // ),
        background: MainPageContainer(),
        collapseMode: CollapseMode.parallax,
        stretchModes: [
          StretchMode.zoomBackground,
        ],
      ),
    );
  }
}
