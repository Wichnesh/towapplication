import 'dart:typed_data';
import 'dart:convert';
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
  RxList<Uint8List>? images; // Use RxList<Uint8List> for observable list
  RxBool? fail;
  RxBool? nA;

  InspectionItem({
    required this.name,
    required this.notes,
    required bool pass,
    required bool fail,
    required bool nA,
    List<Uint8List>? images,
  }) {
    // Initialize RxBools with the initial values
    this.pass = pass.obs;
    this.fail = fail.obs;
    this.nA = nA.obs;
    // Initialize RxList<Uint8List> with the initial value (or an empty list if null)
    this.images = RxList(images ?? []);
  }
}

// To parse this JSON data, do
//
//     final inspectionListModel = inspectionListModelFromJson(jsonString);

InspectionListModel inspectionListModelFromJson(String str) => InspectionListModel.fromJson(json.decode(str));

String inspectionListModelToJson(InspectionListModel data) => json.encode(data.toJson());

class InspectionListModel {
  int status;
  List<InspectionList> inspectionList;

  InspectionListModel({
    required this.status,
    required this.inspectionList,
  });

  factory InspectionListModel.fromJson(Map<String, dynamic> json) => InspectionListModel(
    status: json["status"],
    inspectionList: List<InspectionList>.from(json["inspection_list"].map((x) => InspectionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "inspection_list": List<dynamic>.from(inspectionList.map((x) => x.toJson())),
  };
}

class InspectionList {
  int id;
  int userId;
  int truckId;
  String odometer;
  dynamic inspectionFile;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;
  Truck truck;

  InspectionList({
    required this.id,
    required this.userId,
    required this.truckId,
    required this.odometer,
    required this.inspectionFile,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.truck,
  });

  factory InspectionList.fromJson(Map<String, dynamic> json) => InspectionList(
    id: json["id"],
    userId: json["user_id"] ?? '',
    truckId: json["truck_id"] ??'',
    odometer: json["odometer"] ??'',
    inspectionFile: json["inspection_file"] ??'',
    notes: json["notes"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    truck: Truck.fromJson(json["truck"] ??''),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "truck_id": truckId,
    "odometer": odometer,
    "inspection_file": inspectionFile,
    "notes": notes,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "truck": truck.toJson(),
  };
}

class Truck {
  int id;
  String name;
  String type;
  String duty;
  String year;
  String make;
  dynamic vin;
  String vinNumber;
  String license;
  String note;
  String createdBy;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Truck({
    required this.id,
    required this.name,
    required this.type,
    required this.duty,
    required this.year,
    required this.make,
    required this.vin,
    required this.vinNumber,
    required this.license,
    required this.note,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Truck.fromJson(Map<String, dynamic> json) => Truck(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    duty: json["duty"],
    year: json["year"],
    make: json["make"],
    vin: json["vin"],
    vinNumber: json["vin_number"],
    license: json["license"],
    note: json["note"],
    createdBy: json["created_by"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "duty": duty,
    "year": year,
    "make": make,
    "vin": vin,
    "vin_number": vinNumber,
    "license": license,
    "note": note,
    "created_by": createdBy,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
