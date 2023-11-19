import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import '../../../Utils/Widgets/QRWidget.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import '../../../model/ManageUserList_model.dart';
import '../../../model/Truck_model.dart';
import '../DailController.dart';

class AddCallController extends GetxController {
  final vinText = TextEditingController();
  final licensePlateText = TextEditingController();
  final licenseStateText = TextEditingController();
  final makeText = TextEditingController();
  final modelText = TextEditingController();
  final unitText = TextEditingController();
  final notesText = TextEditingController();
  final odometerText = TextEditingController();
  final invoiceText = TextEditingController();
  final currentDate = TextEditingController();
  final keyLocation = TextEditingController();
  final accountText = TextEditingController();
  final billToText = TextEditingController();
  final reasonText = TextEditingController();
  final pickupText = TextEditingController();
  final destinationText = TextEditingController();
  final nameText = TextEditingController();
  final phoneText = TextEditingController();
  final emailText = TextEditingController();
  final addressText = TextEditingController();
  final contactCity = TextEditingController();
  final contactState = TextEditingController();
  final contactZip = TextEditingController();
  final totalText = TextEditingController();
  final discountText = TextEditingController();
  final grandTotalText = TextEditingController();
  var typeList = ['Select Duty', 'Medium', 'Heavy', 'Light', 'Other'];
  var selectedType = 'Select Type'.obs;
  var colorList = ["Select Color","(Other)","Beige","Black","Blue","Bronze","Brown","Burgundy","Champagne","Gold","Gray","Green","Maroon","Navy","Orange","Pink","Red","Silver","Tan","Teal","White","Yellow"];
  final selectedColor = "Select Color".obs;
  var driveList = ["Select Drive Type","FWD","RWD","4WD","AWD"];
  final selectedDriveType = "Select Drive Type".obs;
  var drivableList = ["Select Drivable","Not Drivable","Drivable","Starts only","Starts with Jump"];
  final selectDrivable = "Select Drivable".obs;
  var reasonList = ["Select Reason","(other)","Abandoned Vehicle","Accident","Dry Run","Expired Plates","Fire Lane Parking","Fuel Delivery","GOA","Handicap Parking","Illegal Parking","Inoperable Vehicle","Jump Start","Lock-Out","No Parking Permit","Police","Private Property Tow","Relocation","Repossession","Reserved Parking","Secondary Accident","See Notes","Service Call","Swap Out","Tire Service","Tow","Winch Out"].obs;
  final selectedReason = "Select Reason".obs;
  var contactType = ['Select Type','Owner','Lienholder'].obs;
  var selectedContactType = 'Select Type'.obs;
  var yearList = List<int>.generate(
      DateTime.now().year - 1984, (index) => DateTime.now().year - index).obs;
  var selectYear = DateTime.now().year.toString().obs;
  File? image;
  var isYesSelected = true.obs;
  var truckList = <TruckList>[].obs;
  var selectedTruck = ''.obs;
  var employees = <Employee>[].obs;
  var selectedEmployee = "".obs;
  var isLoading = false.obs;
  var driverId = "".obs;
  var truckId ="".obs;
  var selectedPriority = "Low".obs;
  Rx<DateTime> selectedDateTime = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTruckList();
    getUserList();
  }

  void selectOption(bool value) {
    isYesSelected.value = value;
  }

  // Property to store the scanned barcode
  RxString scannedBarcode = ''.obs;

  // QR Code Scanner controller
  QRViewController? qrController;

  // Method to open the QR scanner
  void scanBarcode() async {
    qrController?.pauseCamera(); // Pause the camera while using the scanner
    Get.to(const QRViewExample(controller: AddCallController));
  }

  void assignVin() {
    if (scannedBarcode.value.isNotEmpty) {
      vinText.text = scannedBarcode.value;
    }
  }

  void setSelectedPriority(String priority) {
    selectedPriority.value = priority;
  }

  Future<void> selectDateTime(BuildContext context) async {
    final localContext = context;

    final DateTime? picked = await showDatePicker(
      context: localContext,
      initialDate: selectedDateTime.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: localContext,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime.value.subtract(Duration(milliseconds: selectedDateTime.value.millisecond))),
      );

      if (pickedTime != null) {
        selectedDateTime(DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }


  void getUserList() {
    update();
    RequestHttp request = RequestHttp(url: urlEmployee, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        // Parse the response and update the employees list
        UserListModel userListModel = userListModelFromJson(response.body);
        employees.assignAll(userListModel.employees);
        selectedEmployee.value = employees[0].name;// Assign employees list
        Fluttertoast.showToast(msg: "UserList fetch successfully");
      } else {
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
      update();
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      Get.snackbar("Error", onError.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
    });
  }

  void getTruckList() {
    truckList.clear();
    RequestHttp request = RequestHttp(url: urlTruckList, token: Prefs.getString(TOKEN));
    request.get().then((response) async {
      if (response.statusCode == 200) {
        // Parse the response and update the employees list
        TruckListModel userListModel = truckListModelFromJson(response.body);
        truckList.assignAll(userListModel.truckList); // Assign employees list
        selectedTruck.value = truckList[0].name;
        Fluttertoast.showToast(msg: "UserList fetch successfully");
      } else {
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
      update();
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      Get.snackbar("Error", onError.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
    });
  }

  void validation(){
    if(pickupText.text.isEmpty || destinationText.text.isEmpty || accountText.text.isEmpty || billToText.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter Mandatory field");
    }else{
      submit();
    }
  }

  void submit() {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "year":selectYear.value,
      "make":makeText.text,
      "model":modelText.text,
      "type":selectedType.value,
      "vin":vinText.text??"",
      "unit_number":unitText.text??"",
      "license":licensePlateText.text??"",
      "color":selectedColor.value,
      "state":licenseStateText.text??"",
      "odometer":odometerText.text??"",
      "driver_type":selectedDriveType.value??"",
      "drivable":selectDrivable.value,
      "haskey": isYesSelected.value,
      "key_location":keyLocation.text??"",
      "driver_id":driverId.value,
      "truck_id":truckId.value,
      "account":accountText.text,
      "bill_to":billToText.text,
      "reason":selectedReason.value,
      "priority":selectedPriority.value,
      "invoice":"",
      "current_date_time":selectedDateTime.value.toString(),
      "pickup_location":pickupText.text,
      "destination":destinationText.text,
      "notes":notesText.text,
      "contact_type":selectedContactType.value??"",
      "name":nameText.text??"",
      "phone":phoneText.text??"",
      "email":emailText.text??"",
      "contact_address":addressText.text??"",
      "contact_city":contactCity.text??"",
      "contact_state":contactState.text??"",
      "contact_zip":contactZip.text??"",
      "sub_total": totalText.text,
      "discount":discountText.text,
      "grand_total":grandTotalText.text
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestHttp request = RequestHttp(url: urlAddCall, body: requestData, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body.toString());
        }
        final controller = Get.find<DialController>();
        controller.getCallDetailsList();
        Fluttertoast.showToast(msg: "Call Added-successfully");
      } else {
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
      isLoading.value = false;
      update();
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      Get.snackbar("Error", onError.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
      isLoading.value = false;
    });
    update();
  }

}