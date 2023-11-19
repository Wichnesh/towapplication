import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import '../../../model/ManageUserList_model.dart';

class ManageUserListController extends GetxController {

  var isLoading = false.obs;
  var employees = <Employee>[].obs; // Observable list to store employees
  var userList = ['Select Type', 'Manager', 'Dispatcher', 'Driver', 'Accounting'].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserList();
  }


  void getUserList() {
    isLoading.value = true;
    update();
    RequestHttp request = RequestHttp(url: urlEmployee, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        // Parse the response and update the employees list
        UserListModel userListModel = userListModelFromJson(response.body);
        employees.assignAll(userListModel.employees); // Assign employees list
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
