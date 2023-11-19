import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:infinity_tow_appliation/Controller/BottomAppBar_Controller/FloatingActionButton_Controller/AddCall_Controller.dart';
import 'package:infinity_tow_appliation/Controller/DashboardController.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

import '../../Controller/BottomAppBar_Controller/DailController.dart';
import '../../Controller/BottomAppBar_Controller/HomeController.dart';
import '../../Controller/BottomAppBar_Controller/ProfileController.dart';
import '../../Controller/BottomAppBar_Controller/SettingController.dart';
import '../../Utils/pref_manager.dart';
import 'BottomAppBar_Screens/Branch_Dial/Dial_Screen.dart';
import 'BottomAppBar_Screens/Home_Screen.dart';
import 'BottomAppBar_Screens/Profile_Screen.dart';
import 'BottomAppBar_Screens/Settings_Screen.dart';


class Home_Page extends GetView<AddCallController> {
  final DashBoardController dashBoardController = Get.put(DashBoardController());
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());
  final DialController dialController = Get.put(DialController());
  final SettingController settingsController = Get.put(SettingController());
  Home_Page({super.key});
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("token - ${Prefs.getString(TOKEN)}");
    }
    int roleId = Prefs.getInt(ROLEID);
    if(kDebugMode){
      print("roleId - $roleId");
    }
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Obx(() {
        Widget currentScreen = _getPage(dashBoardController.selectedIndex.value);
        return Center(child: currentScreen);
      }),
      floatingActionButton: roleId == 1  ? SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.remove,
        spacing: 10,
        direction: SpeedDialDirection.up,
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Add',
            onTap: () {
              // Handle add action
              Get.toNamed(ROUTE_ADDCALL);
            },
          ),
          // SpeedDialChild(
          //   child: const Icon(Icons.linked_camera),
          //   label: 'New On Scene Call',
          //   onTap: () {
          //     // Handle remove action
          //   },
          // ),
          // SpeedDialChild(
          //   child: const Icon(Icons.newspaper_outlined),
          //   label: 'New Quote',
          //   onTap: () {
          //     // Handle remove action
          //   },
          // ),
        ],
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: roleId == 1 ? BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => dashBoardController.updateSelectedIndex(0),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => dashBoardController.updateSelectedIndex(1),
            ),
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () => dashBoardController.updateSelectedIndex(2),
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () => dashBoardController.updateSelectedIndex(3),
            ),
            SizedBox(width: screenWidth/ 20,),
            const SizedBox(), // This is an empty space for the centered FAB
          ],
        ),
      ) : BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => dashBoardController.updateSelectedIndex(0),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => dashBoardController.updateSelectedIndex(1),
            ),
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () => dashBoardController.updateSelectedIndex(2),
            ),
            // IconButton(
            //   icon: const Icon(Icons.list),
            //   onPressed: () => dashBoardController.updateSelectedIndex(3),
            // ),
            // SizedBox(width: screenWidth/ 20,),
            // const SizedBox(), // This is an empty space for the centered FAB
          ],
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return ProfileScreen();
      case 2:
        return DialScreen();
      case 3:
        return SettingScreen();
      default:
        return const HomeScreen();
    }
  }
}
