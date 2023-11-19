import 'dart:convert';

TruckListModel truckListModelFromJson(String str) => TruckListModel.fromJson(json.decode(str));

String truckListModelToJson(TruckListModel data) => json.encode(data.toJson());

class TruckListModel {
  int status;
  List<TruckList> truckList;

  TruckListModel({
    required this.status,
    required this.truckList,
  });

  factory TruckListModel.fromJson(Map<String, dynamic> json) => TruckListModel(
    status: json["status"],
    truckList: List<TruckList>.from(json["truckList"].map((x) => TruckList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "truckList": List<dynamic>.from(truckList.map((x) => x.toJson())),
  };
}

class TruckList {
  int id;
  String name;
  String type;
  String duty;
  String year;
  String make;
  String? vinNumber;
  String license;
  String note;
  String createdBy;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  TruckList({
    required this.id,
    required this.name,
    required this.type,
    required this.duty,
    required this.year,
    required this.make,
    required this.vinNumber,
    required this.license,
    required this.note,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TruckList.fromJson(Map<String, dynamic> json) => TruckList(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    duty: json["duty"],
    year: json["year"],
    make: json["make"],
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
    "vin_number": vinNumber,
    "license": license,
    "note": note,
    "created_by": createdBy,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}