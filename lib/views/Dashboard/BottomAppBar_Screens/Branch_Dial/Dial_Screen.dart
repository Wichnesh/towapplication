import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';

import '../../../../Controller/BottomAppBar_Controller/DailController.dart';

class DialScreen extends StatelessWidget {
  DialController controller = Get.put(DialController());

  DialScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      minimum: const EdgeInsets.all(8),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Calls',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Expanded(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.callList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Get.toNamed(ROUTE_WAITING);
                          } else if (index == 1) {
                            Get.toNamed(ROUTE_ACTIVE);
                          } else if (index == 2) {
                            Get.toNamed(ROUTE_COMPLETE);
                          } else if(index == 3){
                            Get.toNamed(ROUTE_CANCELLED);
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(controller.callList[index]),
                            trailing: Obx(()=> Stack(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Your onPressed logic here
                                  },
                                  icon: const Icon(Icons.call),
                                  splashRadius: 1.00,
                                ),
                                if (index == 0)
                                  if (controller.waitingList.isNotEmpty)
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${controller.waitingList.length}', // Replace with the actual number you want to display
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                              10, // Adjust the font size as needed
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                if (index == 1)
                                  if (controller.activeList.isNotEmpty)
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${controller.activeList.length}', // Replace with the actual number you want to display
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                              10, // Adjust the font size as needed
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                if (index == 2)
                                  if (controller.completeList.isNotEmpty)
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${controller.completeList.length}', // Replace with the actual number you want to display
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                              10, // Adjust the font size as needed
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                if (index == 3)
                                  if (controller.cancelledList.isNotEmpty)
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${controller.cancelledList.length}', // Replace with the actual number you want to display
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                              10, // Adjust the font size as needed
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              ],
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
