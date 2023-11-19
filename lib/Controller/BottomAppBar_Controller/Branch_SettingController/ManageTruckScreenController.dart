import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Utils/constant.dart';
import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import '../../../model/Truck_model.dart';

class ManageScreenController extends GetxController {
  var isLoading = false.obs;
  var truck = <TruckList>[].obs; // Observable list to store employees
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTruckList();
  }


  void getTruckList() {
    truck.clear();
    isLoading.value = true;
    update();
    RequestHttp request = RequestHttp(url: urlTruckList, token: Prefs.getString(TOKEN));
    request.get().then((response) async {
      if (response.statusCode == 200) {
        // Parse the response and update the employees list
        TruckListModel userListModel = truckListModelFromJson(response.body);
        truck.assignAll(userListModel.truckList); // Assign employees list
        Fluttertoast.showToast(msg: "UserList fetch successfully");
        isLoading.value = false;
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
  }
}