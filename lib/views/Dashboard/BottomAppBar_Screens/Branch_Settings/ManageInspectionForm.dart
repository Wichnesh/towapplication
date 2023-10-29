import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

class ManageInspectionFormScreen extends StatelessWidget {
  const ManageInspectionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Forms'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(ROUTE_EQUIPUMENTINSPECTIONSCREEN);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
