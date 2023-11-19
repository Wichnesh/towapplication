import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/BottomAppBar_Controller/Branch_ProfileController/addUserController.dart';

class AddUserScreen extends StatelessWidget {
  final AddUserController controller = Get.put(AddUserController());

  AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  onChanged: (value) {
                    controller.fullName.value = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  onChanged: (value) {
                    controller.username.value = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value) {
                    controller.password.value = value;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: controller.selectedUserType.value,
                  hint: const Text('Select Truck'),
                  items: controller.userList.map((truck) {
                    return DropdownMenuItem(
                      value: truck,
                      child: Text(truck),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedUserType.value = value!;
                    if (kDebugMode) {
                      print('Selected User Type Index: ${controller.userList.indexOf(value)}');
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    controller.email.value = value;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Status',style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(width: 20,),
                    Obx((){
                      if(controller.status.value){
                        return CupertinoSwitch(value: controller.status.value, onChanged: controller.updateStatusBool);
                      }else{
                        return CupertinoSwitch(value: controller.status.value, onChanged: controller.updateStatusBool);
                      }
                    })
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to save user data or perform other actions
                    controller.validation();
                  },
                  child: const Text('Create User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
