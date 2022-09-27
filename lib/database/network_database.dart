import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jatayu/modals/Activity.dart';
import 'package:jatayu/modals/Post.dart';
import 'package:jatayu/modals/User.dart';
import 'package:jatayu/modals/project.dart';
import 'package:jatayu/Screens/MainPageContainer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

enum GetPost {
  activity,
  faq,
  knowYourPlants,
}

class Network {
  static final instance = FirebaseFirestore.instance;
  static final usersInstance = instance.collection('users');
  static final postInstance = instance.collection('posts');

  static String getCollectionName(GetPost post) {
    switch (post) {
      case GetPost.activity:
        return 'Statuses';
      case GetPost.faq:
        return 'FAQ';
      case GetPost.knowYourPlants:
        return 'knowYourPlants';
    }
  }

  //GET THE QUOTES

  static Future<List<Quotes>> readQuotes() => instance
      .collection('Quotes')
      .withConverter<Quotes>(
        fromFirestore: (snapshot, _) => Quotes.fromMap(snapshot.data()!),
        toFirestore: (Quotes quotes, _) => quotes.toMap(),
      )
      .get()
      .then(
        (value) => value.docs.map((e) => e.data()).toList(),
      );

  static Future<List<Activity>> readActivities(GetPost post) => instance
      .collection(getCollectionName(post))
      .withConverter<Activity>(
        fromFirestore: (snapshot, _) => Activity.fromMap(snapshot.data()!),
        toFirestore: (Activity activity, _) => activity.toMap(),
      )
      .get()
      .then(
        (value) => value.docs.map((e) => e.data()).toList(),
      );

  static Future<List<Project>> readOngoingProjects() => instance
      .collection('Ongoing Projects')
      .withConverter<Project>(
        fromFirestore: (snapshot, _) => Project.fromMap(snapshot.data()!),
        toFirestore: (Project project, _) => project.toMap(),
      )
      .get()
      .then(
        (value) => value.docs.map((e) => e.data()).toList(),
      );

  static Future<List<Project>> getAllUpcomingProjects() => instance
      .collection('Upcoming Projects')
      .withConverter<Project>(
        fromFirestore: (snapshot, _) => Project.fromMap(snapshot.data()!),
        toFirestore: (Project project, _) => project.toMap(),
      )
      .get()
      .then(
        (value) => value.docs.map((e) => e.data()).toList(),
      );

  static Future<List<Project>> getAllVolunteer() => instance
      .collection('Volunteer')
      .withConverter<Project>(
        fromFirestore: (snapshot, _) => Project.fromMap(snapshot.data()!),
        toFirestore: (Project project, _) => project.toMap(),
      )
      .get()
      .then(
        (value) => value.docs.map((e) => e.data()).toList(),
      );

  //Get post, Put Post
  static Future<void> createPost(Post post) async =>
      await postInstance.add(post.toMap());

  // read posts from

  static Future<List<Post>> readAllPosts() async =>
      await postInstance.get().then(
            (value) => value.docs.map(
              (value) {
                Post post = Post.fromMap(value.data(), value.id);
                post.postID = value.id;
                return post;
              },
            ).toList(),
          );
  static Future<List<Post>> readUserPosts(String userId) async =>
      await postInstance
          .where(
            'userID',
            isEqualTo: userId,
          )
          .get()
          .then(
            (value) => value.docs.map(
              (value) {
                Post post = Post.fromMap(value.data(), value.id);
                return post;
              },
            ).toList(),
          );

  static Future<void> updatePost(Post post) async =>
      await postInstance.doc(post.postID).update(post.toMap());
  // function to delete a post
  static Future<void> deletePost(String id, List<String>? fileUrls) async {
    if (fileUrls != null) {
      for (var file in fileUrls) {
        await Network.deleteFile(file);
      }
    }
    return await postInstance.doc(id).delete();
  }

  static Future<AppUser> getUserWithID(String id) async =>
      usersInstance.doc(id).get().then(
            (value) => AppUser.fromMap(
              value.data()!,
            ),
          );

  static Future<AppUser?> readUser(String id) async =>
      await usersInstance.doc(id).get().then((value) =>
          (value.data() != null) ? AppUser.fromMap(value.data()!) : null);

  static Future<List<AppUser>> readAllUsers() async =>
      await usersInstance.get().then(
            (value) => value.docs
                .map(
                  (doc) => AppUser.fromMap(doc.data()),
                )
                .toList(),
          );

  static Future<void> updateUser(AppUser user) async =>
      await usersInstance.doc(user.userID).set(
            user.toMap(),
            SetOptions(
              merge: false,
            ),
          );

  static Future<void> deleteUser(String id) async =>
      await usersInstance.doc(id).delete();
  static Future<String> uploadFile({
    required bool isPost,
    required File file,
    String? updateFileUrl,
  }) async {
    if (updateFileUrl != null) {
      await deleteFile(updateFileUrl);
    }

    final storageRef = FirebaseStorage.instance.ref();

    var imageRef = (isPost)
        ? storageRef.child("post/${file.path.split('/').last}")
        : storageRef.child("userDP/${file.path.split('/').last}");

    try {
      await imageRef.putFile(file);
    } on Exception catch (_) {
      // ...
    }
    return await imageRef.getDownloadURL();
  }

  static Future<void> deleteFile(String url) async {
    final storageRef = FirebaseStorage.instance.refFromURL(url);

    try {
      await storageRef.delete();
    } on Exception catch (_) {
      // ...
    }
    return;
  }
  // static Future<int> addPost(Post post) => postInstance.add(post).then(
  //       (value) {
  //         //Store in storage and put it in firestore
  //         if (value.runtimeType == Post) {
  //           return 200;
  //         } else {
  //           return 404;
  //         }
  //       },
  //     );
}
