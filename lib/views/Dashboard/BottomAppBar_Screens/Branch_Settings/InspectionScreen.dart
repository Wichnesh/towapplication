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
              Obx((){
                if (controller.truckList.isEmpty) {
                  return const Text('Truck Not Available');
                } else {
                  return DropdownButtonFormField<dynamic>(
                    value: controller.selectedTruck.value ?? '',
                    items: controller.truckList.map((truck) {
                      return DropdownMenuItem(
                        value: truck.name ??'',
                        child: Text(truck.name ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedTruck.value = value!;
                    },
                  );
                }
              }),
              const SizedBox(height: 20),
              TextInputBox(
                controller: controller.odometerText,
                hintText: 'Odometer',
                type: TextInputType.number,
                onChange: (value){
                  controller.inspectionList[0].odometer = controller.odometerText.text;
                },
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
                                  Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data[mainIndex].inspectionItems[index].name!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                                      Row(
                                        children: [
                                          data[mainIndex].inspectionItems[index].images!.isNotEmpty ?
                                          Container(
                                            width: 15, // Set the width of the container as per your requirement
                                            height: 15, // Set the height of the container as per your requirement
                                            color: Colors.blue, // Replace 'Colors.blue' with your desired primary color
                                            child: Center(
                                              child: Text(
                                                data[mainIndex].inspectionItems[index].images!.length.toString(),
                                                style: const TextStyle(color: Colors.white), // Set text color to white or any other contrasting color
                                              ),
                                            ),
                                          ) :
                                          Container(),
                                          const SizedBox(width: 10),
                                          InkWell(
                                              onTap:(){
                                                controller.captureImage(mainIndex, index);
                                              },
                                              child: const Icon(Icons.camera_alt_outlined)
                                          ),
                                        ],
                                      )
                                    ],
                                  ),),
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
                                            _showFailDialog(context,mainIndex,index);
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
                onChange: (value){
                  controller.inspectionList[0].notes = controller.notesText.text;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                    onPressed: (){
                      controller.printList();
                    },
                    child: const Text("Next")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the dialog
  void _showFailDialog(BuildContext context, int mainIndex, int index) {
    TextEditingController failReasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notes'),
          content: TextFormField(
            controller: failReasonController,
            decoration: const InputDecoration(labelText: 'Enter Notes'),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String failReason = failReasonController.text;
                // Handle the fail reason, you can pass it to your controller or do something else
                controller.updateNotes(mainIndex, index, failReason);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
