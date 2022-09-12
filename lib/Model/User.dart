import 'dart:convert';

class AppUser {
  String? userID;
  String? name;
  String? imageUrl;
  int? phoneNumber;
  String? userClass;
  String? schoolName;
  // stjohns

  AppUser({
    this.userID,
    this.name,
    this.imageUrl,
    this.phoneNumber,
    this.userClass,
    this.schoolName,
  });

  AppUser copyWith({
    String? userID,
    String? name,
    String? imageUrl,
    int? phoneNumber,
    String? userClass,
    String? schoolName,
  }) {
    return AppUser(
      userID: userID ?? this.userID,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userClass: userClass ?? this.userClass,
      schoolName: schoolName ?? this.schoolName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'userClass': userClass,
      'schoolName': schoolName,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      userID: map['userID'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      phoneNumber: map['phoneNumber']?.toInt(),
      userClass: map['userClass'],
      schoolName: map['schoolName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(userID: $userID, name: $name, imageUrl: $imageUrl, phoneNumber: $phoneNumber, userClass: $userClass, schoolName: $schoolName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.userID == userID &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber &&
        other.userClass == userClass &&
        other.schoolName == schoolName;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        userClass.hashCode ^
        schoolName.hashCode;
  }
}
