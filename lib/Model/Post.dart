import 'dart:convert';

import 'User.dart';

class Post {
  String? postID;
  AppUser? userDetails;
  String? userID;
  String? postTitle;
  String? description;
  String? dateTime;
  String? imageUrl;
  int? likes;
  int? comments;
  int? shares;
  bool isLiked;

  Post({
    this.postID,
    this.userDetails,
    this.userID,
    this.postTitle,
    this.description,
    this.dateTime,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
    this.isLiked = false,
  });

  get docs => null;

  Post copyWith({
    String? postID,
    AppUser? userDetails,
    String? userID,
    String? postTitle,
    String? description,
    String? dateTime,
    String? imageUrl,
    int? likes,
    int? comments,
    int? shares,
    bool? isLiked,
  }) {
    return Post(
      postID: postID ?? this.postID,
      userDetails: userDetails ?? this.userDetails,
      userID: userID ?? this.userID,
      postTitle: postTitle ?? this.postTitle,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userDetails': userDetails?.toMap(),
      'userID': userID,
      'postTitle': postTitle,
      'description': description,
      'dateTime': dateTime,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      // 'isLiked': isLiked,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map, String postID) {
    return Post(
      postID: postID,
      // userDetails: map['userDetails'] != null
      //     ? AppUser.fromMap(map['userDetails'])
      //     : null,
      userID: map['userID'],
      postTitle: map['postTitle'],
      description: map['description'],
      dateTime: map['dateTime'],
      imageUrl: map['imageUrl'],
      likes: map['likes']?.toInt(),
      // comments: map['comments']?.toInt(),
      // shares: map['shares']?.toInt(),
      // isLiked: map['isLiked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(userDetails: $userDetails, userID: $userID, postTitle: $postTitle, description: $description, dateTime: $dateTime, imageUrl: $imageUrl, likes: $likes, comments: $comments, shares: $shares, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.userDetails == userDetails &&
        other.userID == userID &&
        other.postTitle == postTitle &&
        other.description == description &&
        other.dateTime == dateTime &&
        other.imageUrl == imageUrl &&
        other.likes == likes &&
        other.comments == comments &&
        other.shares == shares &&
        other.isLiked == isLiked;
  }

  @override
  int get hashCode {
    return userDetails.hashCode ^
        userID.hashCode ^
        postTitle.hashCode ^
        description.hashCode ^
        dateTime.hashCode ^
        imageUrl.hashCode ^
        likes.hashCode ^
        comments.hashCode ^
        shares.hashCode ^
        isLiked.hashCode;
  }
}
