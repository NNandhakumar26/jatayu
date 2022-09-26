import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'User.dart';

class Post {
  String? postID;
  String? userUrl;
  String? userNameWithClass;
  String? schoolName;
  String? userID;
  String? postTitle;
  String? description;
  DateTime? dateTime;
  List<String>? postUrls;
  int? likes;
  int? comments;
  int? shares;
  bool isLiked;
  Post({
    this.postID,
    this.userUrl,
    this.userNameWithClass,
    this.schoolName,
    this.userID,
    this.postTitle,
    this.description,
    this.dateTime,
    this.postUrls,
    this.likes,
    this.comments,
    this.shares,
    this.isLiked = false,
  });

  Post copyWith({
    String? postID,
    String? userUrl,
    String? userNameWithClass,
    String? schoolName,
    String? userID,
    String? postTitle,
    String? description,
    DateTime? dateTime,
    List<String>? postUrls,
    int? likes,
    int? comments,
    int? shares,
    bool? isLiked,
  }) {
    return Post(
      postID: postID ?? this.postID,
      userUrl: userUrl ?? this.userUrl,
      userNameWithClass: userNameWithClass ?? this.userNameWithClass,
      schoolName: schoolName ?? this.schoolName,
      userID: userID ?? this.userID,
      postTitle: postTitle ?? this.postTitle,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      postUrls: postUrls ?? this.postUrls,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'userUrl': userUrl,
      'userNameWithClass': userNameWithClass,
      'schoolName': schoolName,
      'userID': userID,
      'postTitle': postTitle,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'postUrls': postUrls,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'isLiked': isLiked,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map, String postId) {
    return Post(
      postID: postId,
      userUrl: map['userUrl'],
      userNameWithClass: map['userNameWithClass'],
      schoolName: map['schoolName'],
      userID: map['userID'],
      postTitle: map['postTitle'],
      description: map['description'],
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'])
          : null,
      postUrls: List<String>.from(map['postUrls']),
      likes: map['likes']?.toInt(),
      comments: map['comments']?.toInt(),
      shares: map['shares']?.toInt(),
      isLiked: map['isLiked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Post(postID: $postID, userUrl: $userUrl, userNameWithClass: $userNameWithClass, schoolName: $schoolName, userID: $userID, postTitle: $postTitle, description: $description, dateTime: $dateTime, postUrls: $postUrls, likes: $likes, comments: $comments, shares: $shares, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.postID == postID &&
        other.userUrl == userUrl &&
        other.userNameWithClass == userNameWithClass &&
        other.schoolName == schoolName &&
        other.userID == userID &&
        other.postTitle == postTitle &&
        other.description == description &&
        other.dateTime == dateTime &&
        listEquals(other.postUrls, postUrls) &&
        other.likes == likes &&
        other.comments == comments &&
        other.shares == shares &&
        other.isLiked == isLiked;
  }

  @override
  int get hashCode {
    return postID.hashCode ^
        userUrl.hashCode ^
        userNameWithClass.hashCode ^
        schoolName.hashCode ^
        userID.hashCode ^
        postTitle.hashCode ^
        description.hashCode ^
        dateTime.hashCode ^
        postUrls.hashCode ^
        likes.hashCode ^
        comments.hashCode ^
        shares.hashCode ^
        isLiked.hashCode;
  }
}
