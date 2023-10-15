import 'package:get/get.dart';
import '../Controller/Login_Controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
