import 'package:get/get.dart';
import 'package:jatayu/modals/User.dart';

class AboutController extends GetxController {
  final imageUrl = null;
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  AppUser thisUser = AppUser();
}
