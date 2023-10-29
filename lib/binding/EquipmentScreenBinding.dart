import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Controller/BottomAppBar_Controller/Branch_SettingController/EquipmentScreenController.dart';

class EquipmentScreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EquipmentScreenController());
  }
}