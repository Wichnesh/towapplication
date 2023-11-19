import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/BottomAppBar_Controller/DailController.dart';
import '../../../../Utils/colorUtils.dart';

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
                            const Text("Waiting",style: TextStyle(fontSize: 16)),
                            const Spacer(),
                            Text("${data.call.vehicle.make ?? ''} ${data.call.vehicle.model ?? ''} (${data.call.vehicle.color}) ${data.call.vehicle.driverType}"),
                            const Spacer(),
                            Text(data.call.callDetails.reason ?? ''),
                            const Spacer(),
                            Text(data.call.callDetails.account ?? ''),
                            const Spacer(),
                            Text(data.call.callDetails.currentDateTime),
                            const Spacer(),
                            Text("Pickup : ${data.call.location.pickupLocation ?? ''}"),
                            const Spacer(),
                            Text("Destination : ${data.call.location.destination}" ?? ''),
                            const Spacer(),
                            const Divider(color: black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      controller.showUpdateStatusDialog(data.call.callDetails.currentDateTime ?? '',data.driverId ??'',data.truckId??'',data.call.status,data.id);
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.swap_horiz_sharp),
                                        Text("Update Status")
                                      ],
                                    )),
                                data.call.contactDetails.phone == '' ?
                                const SizedBox() : TextButton(
                                    onPressed: () {

                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.call,size: 18,),
                                        Text("Call Contact")
                                      ],
                                    ))
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
