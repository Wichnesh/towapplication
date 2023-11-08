import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  var isLoading = false.obs;
  var fullName = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var email = ''.obs;
  var status = false.obs;
  var selectedUserType = 'Select Type'.obs;
  var userList =
      ['Select Type', 'Manager', 'Dispatcher', 'Driver', 'Accounting'].obs;
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
    }else{

    }
  }

  void createUser(){

  }
}
