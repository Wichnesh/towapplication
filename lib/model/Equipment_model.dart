import 'package:get/get.dart';

class InspectionModel {
  List<Datum> data;

  InspectionModel({
    required this.data,
  });

  factory InspectionModel.fromJson(Map<String, dynamic> json) => InspectionModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String title;
  List<String> values;

  Datum({
    required this.title,
    required this.values,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    values: List<String>.from(json["values"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "values": List<dynamic>.from(values.map((x) => x)),
  };
}



class EquipmentInspectionModel {
  List<EIMList> data;
  String truck;
  String odometer;
  String notes;
  EquipmentInspectionModel({
    required this.data,
    required this.truck,
    required this.odometer,
    required this.notes
  });

}

class EIMList {
  String title;
  List<InspectionItem> inspectionItems;

  EIMList({
    required this.title,
    required this.inspectionItems,
  });
}

class InspectionItem {
  String? name;
  String? notes;
  RxBool? pass;
  RxBool? fail;
  RxBool? nA;

  InspectionItem({
    required this.name,
    required this.notes,
    required bool pass,
    required bool fail,
    required bool nA,
  }) {
    // Initialize RxBools with the initial values
    this.pass = pass ? pass.obs : false.obs;
    this.fail = fail ? fail.obs : false.obs;
    this.nA = nA ? nA.obs : false.obs;// Initialize data in the constructor body
  }
}

