import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ExpenseController extends GetxController {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final totalCostController = TextEditingController();
  final dateController = TextEditingController();
  final gallonsController = TextEditingController();
  final odometerController = TextEditingController();
  var selectedTruck = 'Select Truck'.obs;
  var selectedCategory = 'Select Category'.obs;
  var selectedImages = <XFile>[].obs;
  var truckList = ['Select Truck','Truck 1','Truck 2'].obs;
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

  ExpenseController() {
    // Ensure unique values in the lists
    assert(truckList.toSet().length == truckList.length);
    assert(categoryList.toSet().length == categoryList.length);
  }

  Future<void> pickImage() async {
    // var status = await Permission.camera.request();
    // if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImages.add(pickedFile);
      }
    // } else {
    //   // Handle the case where the user denies the camera permission
    //   print('Camera permission denied');
    // }
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
}
