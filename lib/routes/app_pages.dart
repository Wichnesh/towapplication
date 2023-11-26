import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';
import 'package:infinity_tow_appliation/binding/EquipmentScreenBinding.dart';
import 'package:infinity_tow_appliation/views/Dashboard/BottomAppBar_Screens/Branch_Dial/CancelledCall_Screen.dart';
import 'package:infinity_tow_appliation/views/Dashboard/BottomAppBar_Screens/Branch_Settings/ManageInspectionForm.dart';
import '../binding/Login_Binding.dart';
import '../binding/ManageInspectionBindling.dart';
import '../binding/ManageTruckListBinding.dart';
import '../binding/ManageUserList_Binding.dart';
import '../binding/RecordExpenseBinding.dart';
import '../binding/Register_Binding.dart';
import '../views/Auth/Login_Screen.dart';
import '../views/Auth/Signup_Screen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Dial/ActiveCall_Screen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Dial/CompletedCall_Screen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Dial/WaitingCall_Screen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Profile/AddUserScreen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Profile/ManageUserList.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Settings/AddTruckScreen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Settings/InspectionScreen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Settings/ManageTruckScreen.dart';
import '../views/Dashboard/BottomAppBar_Screens/Branch_Settings/RecordExpenseScreen.dart';
import '../views/Dashboard/FloatingActionButton_Screen/AddCall_Screen.dart';
import '../views/Dashboard/Home_Page.dart';
import '../views/Dashboard/RoleWiseDashboard/Driver_Dashboard.dart';

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
    GetPage(
        name: ROUTE_MANAGEUSERLIST,
        page: () => const ManageUserListScreen(),
        binding: ManageUserListBinding()),
    GetPage(name: ROUTE_ADDUSERSCREEN, page: () => AddUserScreen()),
    GetPage(
        name: ROUTE_EQUIPUMENTINSPECTIONSCREEN,
        page: () => const InspectionScreen(),
        binding: EquipmentScreenBinding()),
    GetPage(
        name: ROUTE_RECORDEXPENSE,
        page: () => const RecordExpenseScreen(),
        binding: RecordExpenseBinding()),
    GetPage(
        name: ROUTE_MANAGEINSPECTIONFORM,
        page: () => const ManageInspectionFormScreen(),
        binding: ManageInspectionFormBinding()),
    GetPage(name: ROUTE_ADDTRUCKFORM, page: () => AddTruckScreen()),
    GetPage(
        name: ROUTE_MANAGETRUCKS,
        page: () => const ManageTruckScreen(),
        binding: ManageTruckListBinding()),
    GetPage(name: ROUTE_DRIVERHOME, page: () => const DriverDashBoard()),
    GetPage(name: ROUTE_ADDCALL, page: () => AddCallScreen()),
    GetPage(name: ROUTE_WAITING, page: () => WaitingCallScreen()),
    GetPage(name: ROUTE_ACTIVE, page: () => ActiveCallScreen()),
    GetPage(name: ROUTE_COMPLETE, page: () => CompletedCallScreen()),
    GetPage(name: ROUTE_CANCELLED, page: ()=> CancelledCallScreen())
  ];
}
