import 'package:get/get.dart';

class SideBarController extends GetxController {
  var isCollapsed = true.obs;

  void toggleSidebar() {
    isCollapsed.value = !isCollapsed.value;
  }
}
