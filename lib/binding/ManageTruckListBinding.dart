import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Controller/BottomAppBar_Controller/Branch_SettingController/ManageTruckScreenController.dart';

class ManageTruckListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageScreenController());
  }
}