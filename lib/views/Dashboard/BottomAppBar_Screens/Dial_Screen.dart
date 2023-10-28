import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/BottomAppBar_Controller/DailController.dart';


class DialScreen extends StatelessWidget {
  DialController controller = Get.put(DialController());

  DialScreen({super.key});
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
              child: Text('Calls',style: TextStyle(fontSize: 24),),
            ),
            Expanded(
              child: Obx(
                    () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.callList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(controller.callList[index]),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.navigate_next_outlined),
                          ),
                          // You can add more properties or functionalities to the list tile if needed
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