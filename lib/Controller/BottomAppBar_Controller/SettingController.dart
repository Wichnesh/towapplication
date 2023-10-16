import 'package:get/get.dart';

class SettingController extends GetxController {

  RxList<String> settingsList = <String>[
    'Record Expense',
    'Trucks',
    'Equipment Inspection',
    'Map',
  ].obs;

}