import 'package:get/get.dart';
import '../Controller/BottomAppBar_Controller/Branch_SettingController/RecordExpenseController.dart';
import '../Controller/SignUp_Controller.dart';

class RecordExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpenseController());
  }
}
