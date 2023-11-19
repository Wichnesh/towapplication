import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:infinity_tow_appliation/Controller/BottomAppBar_Controller/FloatingActionButton_Controller/AddCall_Controller.dart';

import '../../../Utils/Common_Widget.dart';

class AddCallScreen extends StatelessWidget {
  AddCallScreen({super.key});

  final controller = Get.put(AddCallController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Call'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.00),
        child: Scrollbar(
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Vehicle Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  onPressed: () {
                    controller.scanBarcode();
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextInputBox(
                  controller: controller.unitText,
                  hintText: "Unit Number",
                  type: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextInputBox(
                      controller: controller.licenseStateText,
                      hintText: 'License - Plate',
                      type: TextInputType.name,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextInputBox(
                      controller: controller.licensePlateText,
                      hintText: 'License - State',
                      type: TextInputType.name,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: controller.selectedColor.value,
                hint: const Text('Select Drive Type'),
                items: controller.colorList.map((color) {
                  return DropdownMenuItem(
                    value: color,
                    child: Text(color.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedColor.value = value!.toString();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextInputBox(
                  controller: controller.odometerText,
                  hintText: "Odometer",
                  type: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: controller.selectedDriveType.value,
                hint: const Text('Select Drive Type'),
                items: controller.driveList.map((driveType) {
                  return DropdownMenuItem(
                    value: driveType,
                    child: Text(driveType.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedDriveType.value = value!.toString();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: controller.selectDrivable.value,
                hint: const Text('Select Drivable'),
                items: controller.drivableList.map((drivable) {
                  return DropdownMenuItem(
                    value: drivable,
                    child: Text(drivable.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectDrivable.value = value!.toString();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Has Keys"),
                      const Spacer(),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: controller.isYesSelected.value,
                            onChanged: (bool? value) {
                              if (value != null) {
                                controller.selectOption(value);
                              }
                            },
                          ),
                          const Text('Yes'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: false,
                            groupValue: controller.isYesSelected.value,
                            onChanged: (bool? value) {
                              if (value != null) {
                                controller.selectOption(value);
                              }
                            },
                          ),
                          const Text('No'),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              TextInputBox(
                controller: controller.keyLocation,
                hintText: 'Key Location',
                type: TextInputType.name,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Drivers & Trucks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Obx(() => DropdownButtonFormField<dynamic>(
                    value: controller.selectedEmployee.value ?? '',
                    items: controller.employees.map((employee) {
                      return DropdownMenuItem(
                        value: employee.name ?? '',
                        child: Text(employee.name ?? ''),
                        onTap: () {
                          controller.driverId.value = employee.id.toString();
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedEmployee.value = value!;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => DropdownButtonFormField<dynamic>(
                    value: controller.selectedTruck.value ?? '',
                    items: controller.truckList.map((truck) {
                      return DropdownMenuItem(
                        value: truck.name ?? '',
                        child: Text(truck.name ?? ''),
                        onTap: () {
                          controller.truckId.value = truck.id.toString();
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedTruck.value = value!;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Call Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextInputBox(
                controller: controller.accountText,
                hintText: 'Account',
                type: TextInputType.name,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInputBox(
                controller: controller.billToText,
                hintText: 'Bill to',
                type: TextInputType.name,
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: controller.selectedReason.value,
                hint: const Text('Select Reason'),
                items: controller.reasonList.map((reason) {
                  return DropdownMenuItem(
                    value: reason,
                    child: Text(reason.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedReason.value = value!.toString();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Priority"),
                      const Spacer(),
                      priorityRadioButton('Low'),
                      priorityRadioButton('Normal'),
                      priorityRadioButton('High'),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => TextInputBox(
                    readOnly: true,
                    controller: TextEditingController(
                        text: controller.selectedDateTime.value.toString()),
                    hintText: "Current DateTime",
                    type: TextInputType.none,
                    suffixWidget: IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: () {
                        controller.selectDateTime(context);
                      },
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextInputBox(
                controller: controller.pickupText,
                hintText: 'Pickup',
                type: TextInputType.name,
                suffixWidget: IconButton(
                  icon: const Icon(Icons.location_pin),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextInputBox(
                controller: controller.destinationText,
                hintText: 'Destination',
                type: TextInputType.name,
                suffixWidget: IconButton(
                  icon: const Icon(Icons.location_pin),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Notes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextInputBox(
                controller: controller.notesText,
                hintText: 'Notes',
                type: TextInputType.name,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Charges',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextInputBox(
                controller: controller.totalText,
                hintText: 'Total',
                type: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInputBox(
                controller: controller.discountText,
                hintText: 'Discount',
                type: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInputBox(
                controller: controller.grandTotalText,
                hintText: 'Grand Total',
                type: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {
                controller.validation();
              }, child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  Widget priorityRadioButton(String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: controller.selectedPriority.value,
          onChanged: (String? selectedValue) {
            controller.setSelectedPriority(selectedValue!);
          },
        ),
        Text(value),
      ],
    );
  }
}
