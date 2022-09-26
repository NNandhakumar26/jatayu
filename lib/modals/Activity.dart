import 'dart:convert';

class Activity {
  String? title;
  String? desc;
  String? image;
  int? likes;
  String? category;
  String? date;
  Activity({
    this.title,
    this.desc,
    this.image,
    this.likes,
    this.category,
    this.date,
  });

  // Activity({
  //   this.title,
  //   this.desc,
  //   this.image,
  //   this.likes,
  // });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'desc': desc,
  //     'image': image,
  //     'likes': likes,
  //   };
  // }

  // factory Activity.fromMap(Map<String, dynamic> map) {
  //   return Activity(
  //     title: map['title'],
  //     desc: map['desc'],
  //     image: map['image'],
  //     likes: map['likes']?.toInt(),
  //   );
  // }

  // factory Activity.fromJson(String source) =>
  //     Activity.fromMap(json.decode(source));

  // String toJson() => json.encode(toMap());

  // @override
  // String toString() {
  //   return 'Activity(title: $title, desc: $desc, image: $image, likes: $likes)';
  // }

  Activity copyWith({
    String? title,
    String? desc,
    String? image,
    int? likes,
    String? category,
    String? date,
  }) {
    return Activity(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'image': image,
      'likes': likes,
      'category': category,
      'date': date,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      title: map['title'],
      desc: map['desc'],
      image: map['image'],
      likes: map['likes']?.toInt(),
      category: map['category'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Activity(title: $title, desc: $desc, image: $image, likes: $likes, category: $category, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.title == title &&
        other.desc == desc &&
        other.image == image &&
        other.likes == likes &&
        other.category == category &&
        other.date == date;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        desc.hashCode ^
        image.hashCode ^
        likes.hashCode ^
        category.hashCode ^
        date.hashCode;
  }
}
