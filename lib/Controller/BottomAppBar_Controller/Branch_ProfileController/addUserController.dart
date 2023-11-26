import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import 'ManageUserListController.dart';

class AddUserController extends GetxController {

  var isLoading = false.obs;
  var fullName = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var email = ''.obs;
  var roleID = 0.obs;
  var status = false.obs;
  var selectedUserType = 'Select Type'.obs;
  //var userList = ['Select Type', 'Manager', 'Dispatcher', 'Driver', 'Accounting'].obs;
  var userList = ['Select Type', 'Manager', 'Dispatcher', 'Driver'].obs;


  void updateStatusBool(bool value) {
    status.value = value;
  }

  void saveUserData() {
    // Add logic to save user data to a database or perform other actions
    if (kDebugMode) {
      print(
          'User Data Saved: Full Name: $fullName, Username: $username, Email: $email');
    }
  }

  void validation() {
    if (fullName.value.isEmpty ||
        username.value.isEmpty ||
        password.value.isEmpty ||
        selectedUserType.value.isEmpty ||
        email.value.isEmpty) {
      Fluttertoast.showToast(msg: "Enter all data");
    } else {
      createUser();
    }
  }

  void createUser() {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "name" : fullName.value,
      "username": username.value,
      "email": password.value,
      "password": password.value,
      "role_id": userList.indexOf(selectedUserType.value)
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestHttp request = RequestHttp(url: urlAddUser, body: requestData, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body.toString());
        }
        Fluttertoast.showToast(msg: "user created-successfully");
        ManageUserListController controller = Get.find<ManageUserListController>();
        controller.getUserList();
        Get.back();
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
    update();
  }
}
