import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/constant.dart';

class ManageUserListScreen extends StatelessWidget {
  const ManageUserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage User'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         Get.toNamed(ROUTE_ADDUSERSCREEN);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
