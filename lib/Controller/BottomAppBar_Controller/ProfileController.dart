import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Utils/constant.dart';
import '../../Utils/pref_manager.dart';
import '../../api/request.dart';
import '../../api/url.dart';

class ProfileController extends GetxController {
  RxList<String> profileList = <String>[
    'Manage User\'s',
  ].obs;

  void logout() {
    RequestHttp request = RequestHttp(url: urlLogout, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "log-out successfully");
        await Prefs.setString(TOKEN, "");
        await Prefs.setBoolen('isLoggedIn', false);
        Get.offAllNamed(ROUTE_LOGIN);
      } else {
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      Get.snackbar("Error", onError.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
    });
  }
}
