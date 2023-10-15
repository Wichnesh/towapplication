import 'package:get/get.dart';
import '../Controller/SignUp_Controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
