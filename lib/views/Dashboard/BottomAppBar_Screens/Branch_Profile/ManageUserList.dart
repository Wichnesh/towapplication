import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controller/BottomAppBar_Controller/Branch_ProfileController/ManageUserListController.dart';
import '../../../../Utils/constant.dart';
import '../../../../model/ManageUserList_model.dart';

class ManageUserListScreen extends GetView<ManageUserListController> {
  const ManageUserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage User'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (controller.employees.isEmpty) {
            return const Center(child: Text('No Data'),);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.employees.length,
                itemBuilder: (context, index) {
                  var data = controller.employees[index];
                  return InkWell(
                    onTap: (){
                      if (kDebugMode) {
                        print(data.id);
                      }
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(data.name ?? ''),
                        subtitle:  Text(controller.userList[data.roleId]),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(ROUTE_ADDUSERSCREEN);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// class UserDetailScreen extends StatelessWidget {
//   final Employee data;
//   const UserDetailScreen({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Truck Details'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                 ),
//                 controller: TextEditingController(text: data.name ??''),
//                 readOnly: true,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Added Date',
//                 ),
//                 controller: TextEditingController(text: data.createdAt.toString() ?? ''),
//                 readOnly: true,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Type',
//                 ),
//                 controller: TextEditingController(text: data.type ?? ''),
//                 readOnly: true,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Duty',
//                 ),
//                 controller: TextEditingController(text: data.duty ??''),
//                 readOnly: true,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Year',
//                 ),
//                 controller: TextEditingController(text: data.year ??''),
//                 readOnly: true,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'VIN Number',
//                 ),
//                 controller: TextEditingController(text: data.vinNumber ??''),
//                 readOnly: true,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'License',
//                 ),
//                 controller: TextEditingController(text: data.license ??''),
//                 readOnly: true,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Note',
//                 ),
//                 controller: TextEditingController(text: data.note),
//                 readOnly: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }