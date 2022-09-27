import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jatayu/Screens/post_container.dart';
import 'package:jatayu/Theme.dart';
import 'package:jatayu/Widgets/loading_dialog.dart';
import 'package:jatayu/database/network_database.dart';

import '../modals/Post.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({Key? key}) : super(key: key);

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  Future<List<Post>> postList = Future.value([]);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPosts();
  }

  void initPosts() {
    postList = Network.readUserPosts(FirebaseAuth.instance.currentUser!.uid);
    print(postList.toString());
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    return SafeArea(
      child: Material(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<Post>>(
            future: postList,
            builder: (builder, posts) => ListView.builder(
              itemCount: (posts.data == null) ? 0 : posts.data!.length,
              itemBuilder: (itemBuilder, index) =>
                  (posts.connectionState == ConnectionState.done)
                      ? (posts.data == null)
                          ? Center(
                              child: 'Page is Empty'.plainText,
                            )
                          : PostContainer(
                              thisPost: posts.data![index],
                              isOwnPost: true,
                              onDeleteFunction: () {
                                // TODO: check whether it is working, if not init post again..
                                posts.data!.removeAt(index);
                                // initPosts();
                                print('Post list refreshed');
                                setState(() {});
                              },
                            )
                      : Center(
                          child: CustomLoadingDialog(
                            title: 'Loading Posts',
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
