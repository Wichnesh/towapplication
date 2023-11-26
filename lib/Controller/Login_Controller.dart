import 'dart:convert';

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

  void validation(){
    if(emailText.text.isEmpty || passwordText.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter all data");
    }else{
      loginApiDio();
    }
  }

  void loginApiDio() async {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "username_email": emailText.text.trim(),
      "password": passwordText.text.trim()
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestHttp request = RequestHttp(url: urlLogin, body: requestData, token: '');
    request.post().then((response) async {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        loginmodel login = loginmodel.fromJson(data);
        if (login.status == 'success') {
          if(login.user!.roleId == 1){
            await Prefs.setBoolen('isLoggedIn', true);
            await Prefs.setString(TOKEN, login.authorisation!.token!);
            await Prefs.setInt(ROLEID, login.user!.roleId!);
            if(login.user!.username == null){
              await Prefs.setString(USERNAME, login.user!.name!??'');
            }else{
              await Prefs.setString(USERNAME, login.user!.username!??'');
            }
            await Prefs.setString(EMAIL, login.user!.email!);
            if (kDebugMode) {
              print("Token --- ${Prefs.getString(TOKEN)}");
            }
            Get.offAllNamed(ROUTE_HOME);
            Fluttertoast.showToast(msg: "login-successfully");
          }else if(login.user!.roleId == 3 || login.user!.roleId == 2){
            await Prefs.setBoolen('isLoggedIn', true);
            await Prefs.setString(TOKEN, login.authorisation!.token!);
            await Prefs.setInt(ROLEID, login.user!.roleId!);
            await Prefs.setString(USERNAME, login.user!.username!);
            await Prefs.setString(EMAIL, login.user!.email!);
            if (kDebugMode) {
              print("Token --- ${Prefs.getString(TOKEN)}");
            }
            Get.offAllNamed(ROUTE_HOME);
            Fluttertoast.showToast(msg: "login-successfully");
          }
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        isLoading.value = false;
      } else {
        print(response.statusCode);
        print(response.body);
        Fluttertoast.showToast(msg: "login-failed");
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
