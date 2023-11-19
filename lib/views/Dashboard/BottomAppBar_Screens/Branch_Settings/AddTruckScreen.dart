import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/BottomAppBar_Controller/Branch_SettingController/AddTruckController.dart';
import '../../../../Utils/Common_Widget.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const Text('Truck Details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextInputBox(
              controller: controller.nameText,
              hintText: 'Name',
              type: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: controller.selectedType.value,
              hint: const Text('Select Truck'),
              items: controller.typeList.map((truck) {
                return DropdownMenuItem(
                  value: truck,
                  child: Text(truck),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedType.value = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: controller.selectDuty.value,
              hint: const Text('Select Truck'),
              items: controller.dutyList.map((truck) {
                return DropdownMenuItem(
                  value: truck,
                  child: Text(truck),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectDuty.value = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<int>(
              value: int.parse(controller.selectYear.value),
              hint: const Text('Select Year'),
              items: controller.yearList.map((truck) {
                return DropdownMenuItem(
                  value: truck,
                  child: Text(truck.toString()),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectYear.value = value!.toString();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputBox(
              controller: controller.makeText,
              hintText: 'Make',
              type: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputBox(
              controller: controller.modelText,
              hintText: 'Model',
              type: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputBox(
              controller: controller.vinText,
              hintText: 'VIN',
              type: TextInputType.name,
              suffixWidget: IconButton(
                onPressed: (){
                  controller.scanBarcode();
                },
                icon: const Icon(Icons.camera_alt),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputBox(
              controller: controller.licenseText,
              hintText: 'License',
              type: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Notes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextInputBox(
              controller: controller.notesText,
              hintText: 'Notes',
              type: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: (){
                  controller.validation();
                },
                child: const Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}
