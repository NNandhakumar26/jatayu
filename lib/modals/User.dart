import 'dart:convert';

class AppUser {
  String? userID;
  String? name;
  int? age;
  String? imageUrl;
  String? phoneNumber;
  String? userClass;
  String? schoolName;
  String? emailAddress;
  String? password;

  // stjohns

  AppUser({
    this.userID,
    this.name,
    this.age,
    this.imageUrl,
    this.phoneNumber,
    this.userClass,
    this.schoolName,
    this.emailAddress,
    this.password,
  });

  AppUser copyWith({
    String? userID,
    String? name,
    int? age,
    String? imageUrl,
    String? phoneNumber,
    String? userClass,
    String? schoolName,
    String? emailAddress,
    String? password,
  }) {
    return AppUser(
      userID: userID ?? this.userID,
      name: name ?? this.name,
      age: age ?? this.age,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userClass: userClass ?? this.userClass,
      schoolName: schoolName ?? this.schoolName,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'age': age,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'userClass': userClass,
      'schoolName': schoolName,
      'emailAddress': emailAddress,
      'password': password,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      userID: map['userID'],
      name: map['name'],
      age: map['age']?.toInt(),
      imageUrl: map['imageUrl'],
      phoneNumber: map['phoneNumber'],
      userClass: map['userClass'],
      schoolName: map['schoolName'],
      emailAddress: map['emailAddress'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(userID: $userID, name: $name, age: $age, imageUrl: $imageUrl, phoneNumber: $phoneNumber, userClass: $userClass, schoolName: $schoolName, emailAddress: $emailAddress, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.userID == userID &&
        other.name == name &&
        other.age == age &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber &&
        other.userClass == userClass &&
        other.schoolName == schoolName &&
        other.emailAddress == emailAddress &&
        other.password == password;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        name.hashCode ^
        age.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        userClass.hashCode ^
        schoolName.hashCode ^
        emailAddress.hashCode ^
        password.hashCode;
  }
}
