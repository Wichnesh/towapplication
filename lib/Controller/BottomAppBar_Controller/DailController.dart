import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/colorUtils.dart';

import '../../Utils/constant.dart';
import '../../Utils/pref_manager.dart';
import '../../api/request.dart';
import '../../api/url.dart';
import '../../model/CallList_model.dart';

class DialController extends GetxController {
  var isLoading = false.obs;
  var totalCallDetailsList = <CallDetail>[].obs;
  var waitingList = <CallDetail>[].obs;
  var activeList = <CallDetail>[].obs;
  var completeList = <CallDetail>[].obs;

  RxList<String> callList = <String>[
    'Waiting Calls',
    'Active Calls',
    'Completed Calls',
    'Cancelled Calls',
  ].obs;

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCallDetailsList();
  }

  void getCallDetailsList() {
    totalCallDetailsList.clear();
    waitingList.clear();
    activeList.clear();
    completeList.clear();
    isLoading.value = true;
    update();
    RequestHttp request = RequestHttp(url: urlCallDetail, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        // Parse the response and update the employees list
        TruckListModel userListModel = truckListModelFromJson(response.body);
        try{
          totalCallDetailsList
              .assignAll(userListModel.callDetail);
        }catch(e){
          print(e.toString());
        }
        assignWaitingList();
        assignActiveList();
        assignCompletedList();
        update();
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

  void assignWaitingList() {
    for(var waiting in totalCallDetailsList){
      if(waiting.call.status == 1){
       waitingList.add(waiting);
      }
    }
    update();
    debugPrint(waitingList.length.toString());
  }

  void assignActiveList(){
    for(var active in totalCallDetailsList){
      if(active.call.status == 2 || active.call.status ==3
      || active.call.status ==4 || active.call.status ==5
      || active.call.status ==6){
        activeList.add(active);
      }
    }
    update();
    debugPrint(activeList.length.toString());
  }

  void assignCompletedList(){
    for(var completed in totalCallDetailsList){
      if(completed.call.status == 7){
        completeList.add(completed);
      }
    }
    update();
    debugPrint(completeList.length.toString());
  }

  void showUpdateStatusDialog(String currentDateTime,String driver,String truck,int status,int id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Update Status'),
        content: SizedBox(
          height: 290,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Driver: ',
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: driver ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Truck: ',
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: truck ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Waiting: ',
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: currentDateTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: const TextSpan(
                  text: 'Dispatched: ',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: const TextSpan(
                  text: 'En Route: ',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: const TextSpan(
                  text: 'On Scene: ',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: const TextSpan(
                  text: 'Towing: ',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: const TextSpan(
                  text: 'Destination Arrival: ',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: const TextSpan(
                  text: 'Completed: ',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    updateStatus(id,status);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.swap_horiz_sharp),
                      Text("Update Status")
                    ],
                  )),
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text('Close'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void updateStatus(int callId,int status) {
    isLoading.value = true;
    int updatedStatus = status + 1;
    update();
    Map<String, dynamic> requestData = {
      "call_id":callId,
      "status":updatedStatus
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestHttp request = RequestHttp(url: urlChangeStatus, body: requestData, token: Prefs.getString(TOKEN));
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body.toString());
        }
        Fluttertoast.showToast(msg: "update Status-successfully");
        getCallDetailsList();
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
