import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/BottomAppBar_Controller/Branch_SettingController/AddTruckController.dart';

class AddTruckScreen extends StatelessWidget {
   AddTruckScreen({super.key});

  AddTruckScreenController controller = Get.put(AddTruckScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Truck'),
        centerTitle: true,
      ),
    );
  }
}
