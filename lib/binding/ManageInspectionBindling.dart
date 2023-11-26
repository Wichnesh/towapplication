import 'package:get/get.dart';

import '../Controller/BottomAppBar_Controller/Branch_SettingController/ManageInspectionFormController.dart';

class ManageInspectionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageInspectionFormController());
  }
}