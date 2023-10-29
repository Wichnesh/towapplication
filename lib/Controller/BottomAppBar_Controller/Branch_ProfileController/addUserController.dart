import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  var fullName = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var email = ''.obs;
  var status = false.obs;
  var selectedUserType = 'Select Type'.obs;
  var userList = ['Select Type','Manager','Dispatcher','Driver','Accounting'].obs;
  void updateStatusBool(bool value){
    status.value = value;
  }

  void saveUserData() {
    // Add logic to save user data to a database or perform other actions
    if (kDebugMode) {
      print('User Data Saved: Full Name: $fullName, Username: $username, Email: $email');
    }
  }
}
