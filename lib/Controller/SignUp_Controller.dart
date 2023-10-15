import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

  void SignUpApiDio() async {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "name": "${usernameText.text.trim()}",
      "email": "${emailText.text.trim()}",
      "password": "${passwordText.text.trim()}"
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestDio request = RequestDio(url: urlregister, body: requestData);
    request.post().then((response) async {
      if (response.statusCode == 200) {
        Prefs.setBoolen('isLoggedIn', true);
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
