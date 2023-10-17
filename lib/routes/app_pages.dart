import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

import '../binding/Login_Binding.dart';
import '../binding/RecordExpenseBinding.dart';
import '../binding/Register_Binding.dart';
import '../views/Auth/Login_Screen.dart';
import '../views/Auth/Signup_Screen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Profile/AddUserScreen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Profile/ManageUserList.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Settings/EquipmentScreen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Settings/ManageTruckScreen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Settings/RecordExpenseScreen.dart';
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
    GetPage(name: ROUTE_MANAGEUSERLIST, page: ()=> const ManageUserListScreen()),
    GetPage(name: ROUTE_ADDUSERSCREEN, page: () => AddUserScreen()),
    GetPage(name: ROUTE_EQUIPUMENTINSPECTIONSCREEN, page: () => const EquipmentScreen()),
    GetPage(name: ROUTE_MANAGETRUCKS, page: ()=> const ManageTruckScreen()),
    GetPage(name: ROUTE_RECORDEXPENSE, page: ()=> RecordExpenseScreen(),binding: RecordExpenseBinding())
  ];
}
