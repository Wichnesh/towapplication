import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import 'dart:io';
import 'package:http/http.dart'as http;
import '../../../model/Equipment_model.dart';


class ManageInspectionFormController extends GetxController {
  var isLoading = false.obs;
  var inspection = <InspectionList>[].obs; // Observable list to store employees
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInspectionList();
  }

  void getInspectionList() {
    inspection.clear();
    isLoading.value = true;
    update();
    RequestHttp request = RequestHttp(url: urlInspectionList, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        // Parse the response and update the employees list
        InspectionListModel inspectionListModel = inspectionListModelFromJson(response.body);
        inspection.assignAll(inspectionListModel.inspectionList); // Assign employees list
        //Fluttertoast.showToast(msg: "UserList fetch successfully");
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

  Future<void> downloadAndOpenPDF(String pdfUrl) async {
    try {
      if(pdfUrl.isEmpty){
        Fluttertoast.showToast(msg: "PDF Not Available");
        return;
      }
      String fullUrl = "$urlPdfBase$pdfUrl";
      // Download the PDF file
      var response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        // Get the temporary directory path to store the PDF file
        var tempDir = await getTemporaryDirectory();
        var filePath = '${tempDir.path}/Inspection_Report${DateTime.now()}.pdf';

        // Write the PDF file to the temporary directory
        await File(filePath).writeAsBytes(response.bodyBytes);

        // Open the downloaded PDF file
        await OpenFile.open(filePath);
      } else {
        Fluttertoast.showToast(msg: "Failed to download PDF");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      Get.snackbar("Error", error.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}