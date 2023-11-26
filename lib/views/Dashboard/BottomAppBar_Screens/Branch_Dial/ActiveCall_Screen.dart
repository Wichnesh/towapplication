import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controller/BottomAppBar_Controller/DailController.dart';
import '../../../../Utils/colorUtils.dart';
import '../../../../model/CallList_model.dart';

class ActiveCallScreen extends StatelessWidget {
  ActiveCallScreen({super.key});
  final controller = Get.find<DialController>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (controller.activeList.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.activeList.length,
                itemBuilder: (context, index) {
                  var data = controller.activeList[index];
                  return InkWell(
                    onTap: () {
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
                           if(data.status == 2) Text("Dispatched to ${data.driverName}",style: const TextStyle(fontSize: 16)),
                           if(data.status == 3) Text("${data.driverName} is En Route",style: const TextStyle(fontSize: 16)),
                            if(data.status == 4) Text("${data.driverName} is On Scene",style: const TextStyle(fontSize: 16)),
                            if(data.status == 5) Text("${data.driverName} is Towing",style: const TextStyle(fontSize: 16)),
                            if(data.status == 6) Text("${data.driverName} has Arrived at Destination",style: const TextStyle(fontSize: 16)),
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
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.swap_horiz_sharp),
                                        Text("Update Status")
                                      ],
                                    )),
                                data.contactDetails.phone == '' ?
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

class CallDetailScreen extends StatelessWidget {
  final CallDetail data;
  const CallDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Created Date',
                ),
                controller: TextEditingController(text: data.createdAt.toString() ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'assigned Driver',
                ),
                controller: TextEditingController(text: data.driverName ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'assigned Truck',
                ),
                controller: TextEditingController(text: data.truckName ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Pick Up',
                ),
                controller: TextEditingController(text: data.location.pickupLocation ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Destination',
                ),
                controller: TextEditingController(text: data.location.destination ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Notes',
                ),
                controller: TextEditingController(text: data.location.notes ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Year',
                ),
                controller: TextEditingController(text: data.vehicle.year ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'make',
                ),
                controller: TextEditingController(text: data.vehicle.make ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'model',
                ),
                controller: TextEditingController(text: data.vehicle.model ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'VIN Number',
                ),
                controller: TextEditingController(text: data.vehicle.vin ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Unit Number',
                ),
                controller: TextEditingController(text: data.vehicle.unitNumber ??''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'license',
                ),
                controller: TextEditingController(text: data.vehicle.license ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'State',
                ),
                controller: TextEditingController(text: data.vehicle.state ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Color',
                ),
                controller: TextEditingController(text: data.vehicle.color ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Odometer',
                ),
                controller: TextEditingController(text: data.vehicle.odometer ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'drive type',
                ),
                controller: TextEditingController(text: data.vehicle.driverType ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Drivable',
                ),
                controller: TextEditingController(text: data.vehicle.drivable ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'has Key',
                ),
                controller: data.vehicle.haskey == '0' ? TextEditingController(text: 'No' ?? '') : TextEditingController(text: 'Yes' ?? '') ,
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Key Location',
                ),
                controller: TextEditingController(text: data.vehicle.keyLocation ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Account',
                ),
                controller: TextEditingController(text: data.callDetails.account ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Bill To',
                ),
                controller: TextEditingController(text: data.callDetails.billTo ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Reason',
                ),
                controller: TextEditingController(text: data.callDetails.reason ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Priority',
                ),
                controller: TextEditingController(text: data.callDetails.priority ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Invoice',
                ),
                controller: TextEditingController(text: data.callDetails.invoice ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Client Name',
                ),
                controller: TextEditingController(text: data.contactDetails.name ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Client Phone',
                ),
                controller: TextEditingController(text: data.contactDetails.phone ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Client Email',
                ),
                controller: TextEditingController(text: data.contactDetails.email ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Client Address',
                ),
                controller: TextEditingController(text: data.contactDetails.address ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Client State',
                ),
                controller: TextEditingController(text: data.contactDetails.state ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Client City',
                ),
                controller: TextEditingController(text: data.contactDetails.city ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Client Zip',
                ),
                controller: TextEditingController(text: data.contactDetails.zip ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Sub Total',
                ),
                controller: TextEditingController(text: data.charges.subTotal.toString() ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Discount',
                ),
                controller: TextEditingController(text: data.charges.discount.toString() ?? ''),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.00),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Grand Total',
                ),
                controller: TextEditingController(text: data.charges.grandTotal.toString() ?? ''),
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

