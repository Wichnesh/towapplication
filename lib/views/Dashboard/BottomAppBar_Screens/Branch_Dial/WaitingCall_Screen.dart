import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/BottomAppBar_Controller/DailController.dart';
import '../../../../Utils/colorUtils.dart';
import 'ActiveCall_Screen.dart';

class WaitingCallScreen extends StatelessWidget {
  WaitingCallScreen({super.key});
  final controller = Get.find<DialController>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (controller.waitingList.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.waitingList.length,
                itemBuilder: (context, index) {
                  var data = controller.waitingList[index];
                  return InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(data.id);
                      }
                      Get.to(CallDetailScreen(data: data));
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: screenHeight / 4,
                        padding: const EdgeInsets.fromLTRB(10.00, 10, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Waiting",style: TextStyle(fontSize: 16,color: red)),
                            const Spacer(),
                            Text("${data.vehicle.make ?? ''} ${data.vehicle.model ?? ''} (${data.vehicle.color}) ${data.vehicle.driverType}"),
                            const Spacer(),
                            Text(data.callDetails.reason ?? ''),
                            const Spacer(),
                            Text(data.callDetails.account ?? ''),
                            const Spacer(),
                            Text(data.callDetails.currentDateTime),
                            const Spacer(),
                            Text("Pickup : ${data.location.pickupLocation ?? ''}"),
                            const Spacer(),
                            Text("Destination : ${data.location.destination}" ?? ''),
                            const Spacer(),
                            const Divider(color: black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      controller.showUpdateStatusDialog(data.callDetails.currentDateTime ?? '',data.driverName ??'',data.truckName??'',data.status,data.id);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.move_down_sharp),
                                       if(data.status == 1) const Text("Set to Dispatched")
                                      ],
                                    )),
                                data.contactDetails.phone == '' ?
                                const SizedBox() : TextButton(
                                    onPressed: () {
                                      controller.launchDialer(data.contactDetails.phone);
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.call,size: 18,),
                                        Text("Call Contact")
                                      ],
                                    )),
                                TextButton(
                                    onPressed: () {
                                      controller.showCancelStatusDialog(data.status,data.id);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.cancel),
                                        if(data.status == 1) const Text("Cancel")
                                      ],
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
      }),
    );
  }
}

