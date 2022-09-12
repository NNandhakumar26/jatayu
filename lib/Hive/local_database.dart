import 'package:hive_flutter/hive_flutter.dart';

enum LoggedInAs { Kids, Participant, Admin }

class LocalDB {
  //TODO: USE GETTERS TO GET THE VALUES FROM THE Db
  static late Box mainBox;

  //TODO:ENSURE THIS INITIAL INITIALIZATION IS DONE
  // void main() async {
  //   await Hive.initFlutter();
  // }

  static Future openMainBox() async {
    mainBox = await Hive.openBox('mainBox');
  }

  static String? get phoneNumber =>
      mainBox.get('phoneNumber', defaultValue: null);
  static String? get userID => mainBox.get('userID', defaultValue: null);
  static String? get userName => mainBox.get('userName', defaultValue: null);

  static Future<void> putPhoneNumber({required int number}) =>
      mainBox.put('phoneNumber', number);
  static Future<void> putName({required String name}) =>
      mainBox.put('userName', name);
  static Future<void> putUserID({required String userID}) =>
      mainBox.put('userID', userID);
}

class TEcmp {
  var temp = LocalDB.phoneNumber;
}
