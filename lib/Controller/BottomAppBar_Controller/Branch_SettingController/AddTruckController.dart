import 'dart:convert';
import 'package:async/src/delegate/stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import '../../../Utils/Widgets/QRWidget.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import 'ManageTruckScreenController.dart';

class AddTruckScreenController extends GetxController {
  final nameText = TextEditingController();
  final vinText = TextEditingController();
  final licenseText = TextEditingController();
  final makeText = TextEditingController();
  final modelText = TextEditingController();
  final notesText = TextEditingController();
  var typeList = ['Select Type', 'Wrecker', 'Flat Bed', 'Other'].obs;
  var dutyList = ['Select Duty', 'Medium', 'Heavy', 'Light', 'Other'];
  var yearList = List<int>.generate(
      DateTime.now().year - 1984, (index) => DateTime.now().year - index).obs;
  var selectedType = 'Select Type'.obs;
  var selectDuty = 'Select Duty'.obs;
  var selectYear = DateTime.now().year.toString().obs;
  File? image;

  // Property to store the scanned barcode
  RxString scannedBarcode = ''.obs;

  // QR Code Scanner controller
  QRViewController? qrController;

  // Method to open the QR scanner
  void scanBarcode() async {
    qrController?.pauseCamera(); // Pause the camera while using the scanner
    Get.to(const QRViewExample(controller: AddTruckScreenController));
  }

  void assignVin() {
    if (scannedBarcode.value.isNotEmpty) {
      vinText.text = scannedBarcode.value;
    }
  }

  void validation() {
    if (nameText.text.isEmpty ||
        vinText.text.isEmpty ||
        licenseText.text.isEmpty ||
        selectedType.value.isEmpty ||
        selectDuty.value.isEmpty ||
        selectYear.value.isEmpty ||
        makeText.text.isEmpty ||
        modelText.text.isEmpty ||
        licenseText.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please enter the all data');
    } else {
      print('all data are entered');
      onSubmit();
    }
  }

  void onSubmit() async {
    update();
    Map<String, dynamic> requestData = {
      "name": nameText.text.trim(),
      "type": selectedType.value.trim(),
      "duty" : selectDuty.value,
      "year" : selectYear.value,
      "make" : makeText.text.trim(),
      "vin_photo":"2",
      "model":modelText.text.trim(),
      "license":licenseText.text.trim(),
      "note":notesText.text.trim(),
      "vin_number":vinText.text.trim(),
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestHttp request = RequestHttp(url: urlAddTruck, body: requestData, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Submitted-successfully");
          final ManageScreenController controller = Get.find<ManageScreenController>();
          controller.getTruckList();
          Get.back();
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
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
    update();
  }
}
