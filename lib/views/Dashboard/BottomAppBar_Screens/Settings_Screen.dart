import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_tow_appliation/Utils/constant.dart';
import 'package:infinity_tow_appliation/views/Dashboard/BottomAppBar_Screens/Branch_Settings/RecordExpenseScreen.dart';
import '../../../Controller/BottomAppBar_Controller/SettingController.dart';

class SettingScreen extends StatelessWidget {
  final SettingController settingController = Get.put(SettingController());

   SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      minimum: const EdgeInsets.all(8),
      child: Scaffold(
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: settingController.settingsList.length,
              itemBuilder: (context, index) {
                var data = settingController.settingsList[index];
                return InkWell(
                  onTap: (){
                    if(data == 'Trucks'){
                      debugPrint('Truck selected');
                      Get.toNamed(ROUTE_MANAGETRUCKS);
                    }
                    if(data == 'Record Expense'){
                      debugPrint('Record Expense selected');
                      Get.to(()=>RecordExpenseScreen());
                    }
                    if(data == 'Equipment Inspection'){
                      Get.toNamed(ROUTE_EQUIPUMENTINSPECTIONSCREEN);
                    }
                  },
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(data),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.navigate_next_outlined),
                      ),
                      // You can add more properties or functionalities to the list tile if needed
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
