import 'package:get/get.dart';
import '../Controller/BottomAppBar_Controller/Branch_ProfileController/ManageUserListController.dart';

class ManageUserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageUserListController());
  }
}
