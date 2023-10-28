import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

<<<<<<< Updated upstream
class _Home_PageState extends State<Home_Page> {
=======
class Home_Page extends StatelessWidget {

  final DashBoardController dashBoardController = Get.put(DashBoardController());
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());
  final DialController dialController = Get.put(DialController());
  final SettingController settingsController = Get.put(SettingController());
  Home_Page({super.key});

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard'),
        centerTitle: true,
      ),
    );
  }
<<<<<<< Updated upstream
=======

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
>>>>>>> Stashed changes
}
