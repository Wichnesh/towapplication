
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';
import 'package:infinity_tow_appliation/api/url.dart';

import '../Utils/pref_manager.dart';
import '../api/request.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  TextEditingController usernameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController confirmPasswordText = TextEditingController();

  void validation(){
    if (usernameText.text.isEmpty || emailText.text.isEmpty ||passwordText.text.isEmpty ||
        confirmPasswordText.text.isEmpty) {
      if (kDebugMode) {
        print('Not same');
      }
      Fluttertoast.showToast(msg: "Enter all Mandatory data");
    } else {
      if (passwordText.text ==
          confirmPasswordText.text) {
        if (kDebugMode) {
          print('same');
        }
        signUpApiDio();
      } else {
        if (kDebugMode) {
          print(passwordText.text);
        }
        if (kDebugMode) {
          print(confirmPasswordText.text);
        }
        if (kDebugMode) {
          print('Not same');
        }
        Fluttertoast.showToast(msg: "Password is not Matching");
      }
    }
  }

  void signUpApiDio() async {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "name": usernameText.text.trim(),
      "email": emailText.text.trim(),
      "password": passwordText.text.trim()
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestHttp request = RequestHttp(url: urlRegister, body: requestData, token: '');
    request.post().then((response) async {
      if (response.statusCode == 200) {
        //Prefs.setBoolen('isLoggedIn', true);
        Get.offAllNamed(ROUTE_LOGIN);
        Fluttertoast.showToast(msg: "registered-successfully");
        isLoading.value = false;
      } else {
        throw Exception();
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
