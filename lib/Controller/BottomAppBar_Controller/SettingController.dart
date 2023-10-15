import 'package:get/get.dart';

class SettingController extends GetxController {

  RxList<String> settingsList = <String>[
    'Dispatching',
    'Digital Connections',
    'Record Expense',
    'Trucks',
    'Equipment Inspection',
    'Map',
  ].obs;

}