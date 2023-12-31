//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../../Controller/BottomAppBar_Controller/Branch_SettingController/RecordExpenseController.dart';

class RecordExpenseScreen extends StatelessWidget {
  RecordExpenseScreen({super.key});
 final ExpenseController controller = Get.put(ExpenseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Expense'),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                DropdownButtonFormField<String>(
                  value: controller.selectedTruck.value,
                  hint: const Text('Select Truck'),
                  items: controller.truckList.map((truck) {
                    return DropdownMenuItem(
                      value: truck,
                      child: Text(truck),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedTruck.value = value!;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: controller.selectedCategory.value,
                  hint: const Text('Select Category'),
                  items: controller.categoryList.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedCategory.value = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.detailsController,
                  decoration: const InputDecoration(labelText: 'Details'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.totalCostController,
                  decoration: const InputDecoration(labelText: 'Total Cost'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.gallonsController,
                  decoration: const InputDecoration(labelText: 'Gallons'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.odometerController,
                  decoration: const InputDecoration(labelText: 'Odometer'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (controller.selectedImages.length < 5) {
                      await controller.pickImage();
                    } else {
                      Fluttertoast.showToast(msg: 'Image Limit reached');
                    }
                  },
                  child: const Text('Attach Image'),
                ),
                const SizedBox(height: 20.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 150,
                      child: GestureDetector(
                        onTap: () {
                          // Show the selected image in a dialog box
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Selected Image'),
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.file(File(
                                      controller.selectedImages[index].path)),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.file(
                            File(controller.selectedImages[index].path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    );
                  },
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: controller.selectedImages.length,
                //     itemBuilder: (context, index) {
                //       return GestureDetector(
                //         onTap: () {
                //           // Show the selected image in a dialog box
                //           showDialog(
                //             context: context,
                //             builder: (context) => CupertinoAlertDialog(
                //               title: const Text('Selected Image'),
                //               content: Column(
                //                 children: [
                //                   const SizedBox(
                //                     height: 10,
                //                   ),
                //                   Image.file(File(
                //                       controller.selectedImages[index].path)),
                //                 ],
                //               ),
                //             ),
                //           );
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(vertical: 8.0),
                //           child: Image.file(
                //             File(controller.selectedImages[index].path),
                //             width: 100,
                //             height: 100,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            )),
      ),
    );
  }
}
