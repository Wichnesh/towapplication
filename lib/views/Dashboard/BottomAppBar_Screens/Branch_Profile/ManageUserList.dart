import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controller/BottomAppBar_Controller/Branch_ProfileController/ManageUserListController.dart';
import '../../../../Utils/constant.dart';

class ManageUserListScreen extends GetView<ManageUserListController> {
  const ManageUserListScreen({super.key});

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
          if (controller.employees.isEmpty) {
            return const Center(child: Text('No Data'),);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.employees.length,
                itemBuilder: (context, index) {
                  var data = controller.employees[index];
                  return InkWell(
                    onTap: (){
                      if (kDebugMode) {
                        print(data.id);
                      }
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(data.name ?? ''),
                        subtitle:  Text(controller.userList[data.roleId]),
                      ),
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
          Get.toNamed(ROUTE_ADDUSERSCREEN);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
