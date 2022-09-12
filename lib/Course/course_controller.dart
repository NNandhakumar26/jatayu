import 'package:get/get.dart';

class CourseController extends GetxController {
  bool isShown = false;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isShown = true;
  }
}
