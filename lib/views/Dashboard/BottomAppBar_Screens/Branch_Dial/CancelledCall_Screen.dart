import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controller/BottomAppBar_Controller/DailController.dart';
import '../../../../Utils/colorUtils.dart';
import 'ActiveCall_Screen.dart';

class CancelledCallScreen extends StatelessWidget {
  CancelledCallScreen({super.key});
  final controller = Get.find<DialController>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancelled Calls'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (controller.cancelledList.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.cancelledList.length,
                itemBuilder: (context, index) {
                  var data = controller.cancelledList[index];
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
                            if (data.status == 10)
                              Text("Cancelled by ${data.driverName}",
                                  style: const TextStyle(fontSize: 16)),
                            const Spacer(),
                            Text(
                                "${data.vehicle.make ?? ''} ${data.vehicle.model ?? ''} (${data.vehicle.color}) ${data.vehicle.driverType}"),
                            const Spacer(),
                            Text(data.callDetails.reason ?? ''),
                            const Spacer(),
                            Text(data.callDetails.account ?? ''),
                            const Spacer(),
                            Text(data.callDetails.currentDateTime),
                            const Spacer(),
                            Text(
                                "Pickup : ${data.location.pickupLocation ?? ''}"),
                            const Spacer(),
                            Text("Destination : ${data.location.destination}" ??
                                ''),
                            // const Spacer(),
                            // const Divider(color: black),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     TextButton(
                            //         onPressed: () {
                            //           controller.showUpdateStatusDialog(
                            //               data.callDetails.currentDateTime ??
                            //                   '',
                            //               data.driverName ?? '',
                            //               data.truckName ?? '',
                            //               data.status,
                            //               data.id);
                            //         },
                            //         child: const Row(
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.center,
                            //           children: [
                            //             Icon(Icons.swap_horiz_sharp),
                            //             Text("Update Status")
                            //           ],
                            //         )),
                            //     data.contactDetails.phone == ''
                            //         ? const SizedBox()
                            //         : TextButton(
                            //         onPressed: () {},
                            //         child: const Row(
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.center,
                            //           children: [
                            //             Icon(
                            //               Icons.call,
                            //               size: 18,
                            //             ),
                            //             Text("Call Contact")
                            //           ],
                            //         ))
                            //   ],
                            // )
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
