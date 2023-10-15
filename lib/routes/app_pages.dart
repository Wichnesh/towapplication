import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

import '../binding/Login_Binding.dart';
import '../binding/Register_Binding.dart';
import '../views/Auth/Login_Screen.dart';
import '../views/Auth/Signup_Screen.dart';
import '../views/Dashboard/Home_Page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: ROUTE_LOGIN,
        page: () => const Login_Page(),
        binding: LoginBinding()),
    GetPage(
        name: ROUTE_REGISTER,
        page: () => const Signup_Page(),
        binding: RegisterBinding()),
    GetPage(name: ROUTE_HOME, page: () => Home_Page()),
  ];
}
