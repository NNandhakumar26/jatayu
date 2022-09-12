import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Model/Post.dart';
import 'package:jatayu/Network/data_fetching.dart';
import 'package:jatayu/Screens/Activities.dart';
import 'package:jatayu/Screens/chat_screen.dart';
import 'package:jatayu/Screens/mainPageContents.dart';
import 'package:jatayu/Screens/post_container.dart';
import 'package:jatayu/Theme.dart';

import 'MainPageContainer.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scrollController = ScrollController();
  bool zeroProducts = false;
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 10;
  DocumentSnapshot? lastDocument;
  List<Post> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    getUsers();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 2) {
        getUsers();
      }
    });
    super.initState();
  }

  getUsers() async {
    if (!hasMore) {
      return;
    }
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
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
    lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    setState(
      () {
        isLoading = false;
        // for (var i = 0; i < 4; i++)
        posts.addAll(
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          const ThisPageSliverAppBar(),
          ThisPageSliverToBoxAdapter(posts),
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //     [
          //       ...posts
          //           .map(
          //             (e) => PostContainer(
          //               thisPost: e,
          //             ),
          //           )
          //           .toList(),
          //       // CustomFutureBuilder<List<Post>>(
          //       //   onSuccessWidget: (data) => Column(
          //       //     children: posts
          //       //         .map(
          //       //           (e) => PostContainer(
          //       //             thisPost: e,
          //       //           ),
          //       //         )
          //       //         .toList(),
          //       //   ),
          //       //   futureFunction: Network.getAllPosts(),
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
          //             futureFunction: Network.getAllPosts(),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
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
      //               CustomPostContainer(),
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
      //               //   futureFunction: Network.getAllPosts(),
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
}

class ThisPageSliverToBoxAdapter extends StatelessWidget {
  final List<Post> posts;
  ThisPageSliverToBoxAdapter(
    this.posts, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Center(
              child: const Text(
                'Notification Content can be scrolled as a Text Here (can be disabled)',
                style: TextStyle(fontSize: 8),
              ),
            ),
          ),
          CustomPostContainer(),
          SizedBox(
            height: 8,
          ),
          Container(
            height: Get.height / 3.2,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Activities(),
          ),
          ...posts
              .map(
                (e) => PostContainer(
                  thisPost: e,
                ),
              )
              .toList(),
        ],
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
      title: CompanyAppbarRow(),
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

class CompanyAppbarRow extends StatelessWidget {
  final String? title;
  const CompanyAppbarRow({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? 'Jatayu Charitable Trust',
          style: Style.headline.copyWith(
            color: Style.nearlyDarkBlue.withOpacity(0.87),
            letterSpacing: -0.4,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
              iconSize: 18,
              splashColor: Style.nearlyDarkBlue.withOpacity(0.32),
              splashRadius: 20,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const ChatScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.forum_rounded,
                color: Colors.black54,
              ),
              iconSize: 18,
              splashColor: Style.nearlyDarkBlue.withOpacity(0.32),
              splashRadius: 20,
            ),
          ],
        )
      ],
    );
  }
}
