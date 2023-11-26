import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';
import 'package:open_file/open_file.dart';

import '../../../../Controller/BottomAppBar_Controller/Branch_SettingController/ManageInspectionFormController.dart';

class ManageInspectionFormScreen extends GetView<ManageInspectionFormController>  {
  const ManageInspectionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection List'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (controller.inspection.isEmpty) {
            return const Center(child: Text('No Data'),);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.inspection.length,
                itemBuilder: (context, index) {
                  var data = controller.inspection[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: const Icon(Icons.newspaper),
                      title: Text(data.truck.name ?? ''),
                      subtitle:  Text(data.createdAt.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.picture_as_pdf),
                        onPressed: (){
                            controller.downloadAndOpenPDF(data.inspectionFile ?? '');
                        },
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
          Get.toNamed(ROUTE_EQUIPUMENTINSPECTIONSCREEN);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
