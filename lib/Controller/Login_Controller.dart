import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Utils/constant.dart';
import '../Utils/pref_manager.dart';
import '../api/request.dart';
import '../api/url.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  void loginApiDio() async {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "email": "${emailText.text.trim()}",
      "password": "${passwordText.text.trim()}"
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestDio request = RequestDio(url: urllogin, body: requestData);
    request.post().then((response) async {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        loginmodel login = loginmodel.fromJson(data);
        if (login.status == 'success') {
          Prefs.setBoolen('isLoggedIn', true);
          Get.offAllNamed(ROUTE_HOME);
          Fluttertoast.showToast(msg: "login-successfully");
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
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
