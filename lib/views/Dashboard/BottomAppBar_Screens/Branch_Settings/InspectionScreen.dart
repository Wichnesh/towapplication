import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/BottomAppBar_Controller/Branch_SettingController/EquipmentScreenController.dart';
import '../../../../Utils/Common_Widget.dart';

class InspectionScreen extends GetView<EquipmentScreenController> {
  const InspectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Inspection Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
              TextInputBox(
                controller: controller.odometerText,
                hintText: 'Odometer',
                type: TextInputType.number,
                suffixWidget: InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print("Camera Selected");
                    }
                  },
                  child: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.inspectionList[0].data
                        .length, // Use the dynamic item count here
                    itemBuilder: (context, mainIndex) {
                      var data = controller.inspectionList[0].data;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(1, 10, 0, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[mainIndex].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Divider(thickness: 2,),
                            for (var index = 0; index < data[mainIndex].inspectionItems.length; index++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data[mainIndex].inspectionItems[index].name!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                                      const Icon(Icons.camera_alt_outlined),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomRadioButton(
                                        isSelected: data[mainIndex].inspectionItems[index].pass!.value,
                                        fillColor: Colors.green,
                                        borderColor: Colors.black,
                                        onTap: () {
                                          controller.updateInspectionStatus(mainIndex,index, 'Pass');
                                        },
                                      ),
                                      const Text('Pass',style: TextStyle(fontWeight: FontWeight.w500),),
                                      CustomRadioButton(
                                          isSelected: data[mainIndex].inspectionItems[index].fail!.value,
                                          fillColor: Colors.red,
                                          borderColor: Colors.black,
                                          onTap: (){
                                            controller.updateInspectionStatus(mainIndex,index, 'Fail');
                                          }),
                                      const Text('Fail',style: TextStyle(fontWeight: FontWeight.w500)),
                                      CustomRadioButton(
                                          isSelected: data[mainIndex].inspectionItems[index].nA!.value,
                                          fillColor: Colors.grey,
                                          borderColor: Colors.black,
                                          onTap: (){
                                            controller.updateInspectionStatus(mainIndex,index, 'N/A');
                                          }),
                                      const Text('N/A',style: TextStyle(fontWeight: FontWeight.w500)),
                                    ],
                                  ))
                                ],
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextInputBox(
                controller: controller.notesText,
                hintText: 'Notes',
                type: TextInputType.text,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                    onPressed: (){},
                    child: const Text("Save")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
