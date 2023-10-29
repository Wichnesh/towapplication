import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/Equipment_model.dart';

class EquipmentScreenController extends GetxController {
  var inspectionItems = <Datum>[].obs;
  var inspectionList = <EquipmentInspectionModel>[].obs;
  var selectedTruck = "Select Truck".obs;
  var truckList = ['Select Truck','Truck 1','Truck 2'].obs;
  TextEditingController odometerText = TextEditingController();
  TextEditingController notesText = TextEditingController();
  // Define a RxString to hold the selected status (Pass, Fail, N/A)
  RxString selectedStatus = ''.obs;
  @override
  void onInit() {
    parseJson();
    super.onInit();
  }

  // Setter method to update the selected status
  void setSelectedStatus(String status) {
    selectedStatus.value = status;
  }


  // Update the status of InspectionItem at the given index
  void updateInspectionStatus(int mainIndex,int index, String status) {
    if (inspectionList.isNotEmpty &&
        mainIndex >= 0 &&
        mainIndex < inspectionList[0].data.length &&
        inspectionList[0].data[mainIndex].inspectionItems.isNotEmpty) {
      var item = inspectionList[0].data[mainIndex].inspectionItems[index];
      switch (status) {
        case 'Pass':
          item.pass!.value = true;
          item.fail!.value = false;
          item.nA!.value = false;
          break;
        case 'Fail':
          item.pass!.value = false;
          item.fail!.value = true;
          item.nA!.value = false;
          break;
        case 'N/A':
          item.pass!.value = false;
          item.fail!.value = false;
          item.nA!.value = true;
          break;
      }
    }
  }


  void parseJson() {
    String jsonData = '''
     {
    "data": [
        {
            "title": "Underhood/Engine Compartment",
            "values": [
                "Engine Oil Level",
                "Radiator Fluid Level",
                "Battery Fluid Level",
                "Windshield Washer Fluid Level",
                "Engine Hoses/Belts",
                "Terminals"
            ]
        },
        {
            "title": "Interior/Cab",
            "values": [
                "Brakes",
                "Steering",
                "Transmission",
                "Mirrors",
                "Gauge/Instruments",
                "Controls (Equipment)",
                "Radio (Two-Way)",
                "Damage/Cleanliness"
            ]
        },
        {
            "title": "Exterior",
            "values": [
                "Tires",
                "Turn Signal",
                "Headlights",
                "Tail/Brakes Lights",
                "Windshield Wipers",
                "Fresh Body Damage",
                "Cleanliness"
            ]
        },
        {
            "title": "Lift/Boom Equipment",
            "values": [
                "Hoist",
                "Winch",
                "Chains",
                "Lift Cables",
                "Cycle Lift",
                "Tire Blocks",
                "Snatch Blocks"
            ]
        },
        {
            "title": "Safety Equipment",
            "values": [
                "Fire Extinguisher",
                "Web Cutter",
                "Triangles",
                "First Aid Kit",
                "Back-Up Alarm",
                "Rear Door Buzzer (LTV only)",
                "Biohazard Kit"
            ]
        },
        {
            "title": "Other",
            "values": [
                "Registration/Insurance",
                "Driver's License"
            ]
        }
    ]
}
    ''';

    var data = json.decode(jsonData);

    InspectionModel iLisData = InspectionModel.fromJson(data);
    for(var list in iLisData.data){
      inspectionItems.add(list);
    }
    var inspectionModel = EquipmentInspectionModel(
      data: [],
      truck: "", // Provide actual truck details
      odometer: "", // Provide actual odometer reading
      notes: "", // Provide any additional notes
    );
    for(var element in inspectionItems.value){
        var list = EIMList(
            title: element.title,
            inspectionItems: []
        );
        for(var value in element.values){
          var inspectionList = InspectionItem(
            name: value,
            notes: "",
            pass: true,
            fail: false,
            nA: false,
          );
          list.inspectionItems.add(inspectionList);
        }
        inspectionModel.data.add(list);
    }
    inspectionList.add(inspectionModel);
  }
}
