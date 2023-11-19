import 'dart:convert';
import 'dart:io';
import 'package:async/src/delegate/stream.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import '../../../model/Truck_model.dart';

class ExpenseController extends GetxController {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final totalCostController = TextEditingController();
  final dateController = TextEditingController();
  final gallonsController = TextEditingController();
  final odometerController = TextEditingController();
  var selectedTruck = ''.obs;
  var selectedCategory = 'Select Category'.obs;
  var selectedImages = <XFile>[].obs;
  File? image;
  //var truckList = ['Select Truck', 'Truck 1', 'Truck 2'].obs;
  var categoryList = [
    'Select Category',
    'Fuel',
    'Maintenance',
    'Repairs',
    'Wash',
    'Tolls',
    'Misc',
    'Preventative Maintenance',
    'Licensing/Permits'
  ].obs;

  var truckList = <TruckList>[].obs;

  ExpenseController() {
    // Ensure unique values in the lists
    //assert(truckList.toSet().length == truckList.length);
    assert(categoryList.toSet().length == categoryList.length);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   getTruckList();
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

  Future<void> pickImage() async {
    // var status = await Permission.camera.request();
    // if (status.isGranted) {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      // Handle the case where the user denies the camera permission
      Fluttertoast.showToast(msg: 'Camera permission denied');
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    detailsController.dispose();
    totalCostController.dispose();
    dateController.dispose();
    gallonsController.dispose();
    odometerController.dispose();
    super.onClose();
  }

  void validation() {
    if (titleController.text.isEmpty ||
        detailsController.text.isEmpty ||
        totalCostController.text.isEmpty ||
        dateController.text.isEmpty ||
        gallonsController.text.isEmpty ||
        odometerController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Select all validation');
    } else {
      onSubmit();
    }
  }

  void onSubmit() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Prefs.getString(TOKEN)}"
    };
    var uri = Uri.parse(urlAddExpense);
    var request = http.MultipartRequest("POST", uri);
    if(image == null){

    }else{
      var stream = new http.ByteStream(DelegatingStream.typed(image!.openRead()));
      // get file length
      var length = await image!.length(); //imageFile is your image file
      var multipartFileSign = http.MultipartFile('file', stream, length,
          filename: image!.path); // multipart that takes file
      request.files.add(multipartFileSign);
    }
    request.headers.addAll(headers);
    request.fields['truck_id'] = "5";
    request.fields['category'] = selectedCategory.value;
    request.fields['title'] = titleController.text;
    request.fields['details'] = detailsController.text;
    request.fields['total_cost'] = totalCostController.text;
    request.fields['date'] = dateController.text;
    request.fields['gallons_unit'] = gallonsController.text;
    request.fields['odometer'] = odometerController.text;
    // request.fields['file'] = "";
    print('REQUEST  : - ${request.fields}  ${request.files}');

// send
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) async {
      //Get.back();
      try {
        print(value);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Record Created Successfully");
          Get.offAllNamed(ROUTE_HOME);
        }else{
          Get.snackbar("Error", response.statusCode.toString(),
              colorText: Colors.white,
              backgroundColor: Colors.blue,
              snackPosition: SnackPosition.TOP);
        }
        //isLoading.value = false;
      } catch (e) {
        print(e.toString());
      }
      // Get.back();
      update();
    });
  }
}
