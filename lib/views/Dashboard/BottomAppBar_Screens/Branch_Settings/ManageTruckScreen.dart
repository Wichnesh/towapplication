import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

import '../../../../Controller/BottomAppBar_Controller/Branch_SettingController/ManageTruckScreenController.dart';

class ManageTruckScreen extends GetView<ManageScreenController> {
  const ManageTruckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage User'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (controller.truck.isEmpty) {
            return const Center(child: Text('No Data'),);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.truck.length,
                itemBuilder: (context, index) {
                  var data = controller.truck[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: const Icon(Icons.car_repair_rounded),
                      title: Text(data.name ?? ''),
                      subtitle:  Text(data.make),
                    ),
                  );
                },
              ),
            );
          }
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(ROUTE_ADDTRUCKFORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
