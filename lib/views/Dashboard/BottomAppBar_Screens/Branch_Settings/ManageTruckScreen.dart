import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

import '../../../../Controller/BottomAppBar_Controller/Branch_SettingController/ManageTruckScreenController.dart';
import '../../../../model/Truck_model.dart';

class ManageTruckScreen extends GetView<ManageScreenController> {
  const ManageTruckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truck List'),
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
                  return InkWell(
                    onTap: (){
                      Get.to(TruckDetailScreen(data: controller.truck[index],));
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: const Icon(Icons.car_repair_rounded),
                        title: Text(data.name ?? ''),
                        subtitle:  Text(data.make),
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
          Get.toNamed(ROUTE_ADDTRUCKFORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}




class TruckDetailScreen extends StatelessWidget {
  final TruckList data;
  const TruckDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truck Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                controller: TextEditingController(text: data.name ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Added Date',
                ),
                controller: TextEditingController(text: data.createdAt.toString() ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Type',
                ),
                controller: TextEditingController(text: data.type ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Duty',
                ),
                controller: TextEditingController(text: data.duty ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Year',
                ),
                controller: TextEditingController(text: data.year ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'VIN Number',
                ),
                controller: TextEditingController(text: data.vinNumber ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'License',
                ),
                controller: TextEditingController(text: data.license ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Note',
                ),
                controller: TextEditingController(text: data.note),
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}