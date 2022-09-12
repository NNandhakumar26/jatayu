import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jatayu/Model/Activity.dart';
import 'package:jatayu/Model/Post.dart';
import 'package:jatayu/Model/User.dart';
import 'package:jatayu/Model/project.dart';
import 'package:jatayu/Screens/MainPageContainer.dart';

enum GetPost {
  activity,
  faq,
  knowYourPlants,
}

class Network {
  static final instance = FirebaseFirestore.instance;
  static final postInstance = instance.collection('Posts');

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

  static Future<List<Quotes>> getAllQuotes() => instance
      .collection('Quotes')
      .withConverter<Quotes>(
        fromFirestore: (snapshot, _) => Quotes.fromMap(snapshot.data()!),
        toFirestore: (Quotes quotes, _) => quotes.toMap(),
      )
      .get()
      .then(
        (value) => value.docs.map((e) => e.data()).toList(),
      );

  static Future<List<Activity>> getAllActivities(GetPost post) => instance
      .collection(getCollectionName(post))
      .withConverter<Activity>(
        fromFirestore: (snapshot, _) => Activity.fromMap(snapshot.data()!),
        toFirestore: (Activity activity, _) => activity.toMap(),
      )
      .get()
      .then(
        (value) => value.docs.map((e) => e.data()).toList(),
      );

  static Future<List<Project>> getAllOngoingProjects() => instance
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

  static Future<List<Post>> getAllPosts({int? limit}) async {
    return await postInstance
        .withConverter<Post>(
          fromFirestore: (snapshot, _) {
            return Post.fromMap(snapshot.data()!, snapshot.id);
          },
          toFirestore: (Post post, _) => post.toMap(),
        )
        .limit(limit ?? 10)
        .get()
        .then(
          (value1) => value1.docs.map((e) => e.data()).toList(),
        )
        .then(
      (value) async {
        for (var item in value) {
          item.userDetails = await getUserWithID(item.userID!);
          item.userDetails!.userID = item.userID;
        }
        return value;
      },
    );
  }

  static Future<AppUser> getUserWithID(String id) {
    return instance
        .collection('Users')
        .withConverter(
            fromFirestore: (snapshot, _) => AppUser.fromMap(snapshot.data()!),
            toFirestore: (AppUser user, _) => user.toMap())
        .doc(id)
        .get()
        .then((value) => value.data()!);
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
