import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

class ManageTruckScreen extends StatelessWidget {
  const ManageTruckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Truck'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(ROUTE_ADDTRUCKFORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
