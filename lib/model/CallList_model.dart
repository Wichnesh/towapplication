// To parse this JSON data, do
//
//     final truckListModel = truckListModelFromJson(jsonString);

import 'dart:convert';

TruckListModel truckListModelFromJson(String str) =>
    TruckListModel.fromJson(json.decode(str));

String truckListModelToJson(TruckListModel data) => json.encode(data.toJson());

class TruckListModel {
  int status;
  List<CallDetail> callDetail;

  TruckListModel({
    required this.status,
    required this.callDetail,
  });

  factory TruckListModel.fromJson(Map<String, dynamic> json) => TruckListModel(
        status: json["status"] ?? 0,
        callDetail: List<CallDetail>.from(
            json["callDetail"].map((x) => CallDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "callDetail": List<dynamic>.from(callDetail.map((x) => x.toJson())),
      };
}

class CallDetail {
  int id;
  int userId;
  String driverId;
  String? truckId;
  int addCallId;
  DateTime createdAt;
  DateTime updatedAt;
  Call call;

  CallDetail({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.truckId,
    required this.addCallId,
    required this.createdAt,
    required this.updatedAt,
    required this.call,
  });

  factory CallDetail.fromJson(Map<String, dynamic> json) => CallDetail(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        driverId: json["driver_id"] ?? "",
        truckId: json["truck_id"] ?? "",
        addCallId: json["add_call_id"] ?? 0,
        createdAt: _parseDateTime(json["created_at"]),
        updatedAt: _parseDateTime(json["updated_at"]),
        call: Call.fromJson(json["call"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "driver_id": driverId,
        "truck_id": truckId,
        "add_call_id": addCallId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "call": call.toJson(),
      };
}

class Call {
  int id;
  int userId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  Vehicle vehicle;
  CallDetails callDetails;
  Location location;
  Charges charges;
  ContactDetails contactDetails;

  Call({
    required this.id,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicle,
    required this.callDetails,
    required this.location,
    required this.charges,
    required this.contactDetails,
  });

  factory Call.fromJson(Map<String, dynamic> json) => Call(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        status: json["status"] ?? 0,
        createdAt: _parseDateTime(json["created_at"]),
        updatedAt: _parseDateTime(json["updated_at"]),
        vehicle: Vehicle.fromJson(json["vehicle"] ?? {}),
        callDetails: CallDetails.fromJson(json["call_details"] ?? {}),
        location: Location.fromJson(json["location"] ?? {}),
        charges: Charges.fromJson(json["charges"] ?? {}),
        contactDetails: ContactDetails.fromJson(json["contact_details"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "vehicle": vehicle.toJson(),
        "call_details": callDetails.toJson(),
        "location": location.toJson(),
        "charges": charges.toJson(),
        "contact_details": contactDetails.toJson(),
      };
}

class CallDetails {
  int id;
  int userId;
  String account;
  String billTo;
  String reason;
  String priority;
  String? invoice;
  String currentDateTime;
  int addCallId;
  DateTime createdAt;
  DateTime updatedAt;

  CallDetails({
    required this.id,
    required this.userId,
    required this.account,
    required this.billTo,
    required this.reason,
    required this.priority,
    required this.invoice,
    required this.currentDateTime,
    required this.addCallId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CallDetails.fromJson(Map<String, dynamic> json) => CallDetails(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        account: json["account"] ?? "",
        billTo: json["bill_to"] ?? "",
        reason: json["reason"] ?? "",
        priority: json["priority"] ?? "",
        invoice: json["invoice"] ?? "",
        currentDateTime: json["current_date_time"] ?? "",
        addCallId: json["add_call_id"] ?? 0,
        createdAt: _parseDateTime(json["created_at"]),
        updatedAt: _parseDateTime(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "account": account,
        "bill_to": billTo,
        "reason": reason,
        "priority": priority,
        "invoice": invoice,
        "current_date_time": currentDateTime,
        "add_call_id": addCallId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Charges {
  int id;
  int userId;
  int? subTotal;
  int? discount;
  int? grandTotal;
  int addCallId;
  DateTime createdAt;
  DateTime updatedAt;

  Charges({
    required this.id,
    required this.userId,
    required this.subTotal,
    required this.discount,
    required this.grandTotal,
    required this.addCallId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        subTotal: json["sub_total"] ?? 0,
        discount: json["discount"] ?? 0,
        grandTotal: json["grand_total"] ?? 0,
        addCallId: json["add_call_id"] ?? 0,
        createdAt: _parseDateTime(json["created_at"]),
        updatedAt: _parseDateTime(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "sub_total": subTotal,
        "discount": discount,
        "grand_total": grandTotal,
        "add_call_id": addCallId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ContactDetails {
  int id;
  int userId;
  String type;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? state;
  String? city;
  String? zip;
  int addCallId;
  DateTime createdAt;
  DateTime updatedAt;

  ContactDetails({
    required this.id,
    required this.userId,
    required this.type,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.state,
    required this.city,
    required this.zip,
    required this.addCallId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        type: json["type"] ?? "",
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        address: json["address"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        zip: json["zip"] ?? "",
        addCallId: json["add_call_id"] ?? 0,
        createdAt: _parseDateTime(json["created_at"]),
        updatedAt: _parseDateTime(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "state": state,
        "city": city,
        "zip": zip,
        "add_call_id": addCallId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Location {
  int id;
  int userId;
  String pickupLocation;
  String destination;
  String? notes;
  int addCallId;
  DateTime createdAt;
  DateTime updatedAt;

  Location({
    required this.id,
    required this.userId,
    required this.pickupLocation,
    required this.destination,
    required this.notes,
    required this.addCallId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        pickupLocation: json["pickup_location"] ?? "",
        destination: json["destination"] ?? "",
        notes: json["notes"] ?? "",
        addCallId: json["add_call_id"] ?? 0,
        createdAt: _parseDateTime(json["created_at"]),
        updatedAt: _parseDateTime(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "pickup_location": pickupLocation,
        "destination": destination,
        "notes": notes,
        "add_call_id": addCallId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Vehicle {
  int id;
  int userId;
  String year;
  String make;
  String model;
  String type;
  String vin;
  String? unitNumber;
  String? license;
  String state;
  String color;
  String odometer;
  String driverType;
  String drivable;
  String haskey;
  String keyLocation;
  int addCallId;
  DateTime createdAt;
  DateTime updatedAt;

  Vehicle({
    required this.id,
    required this.userId,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
    required this.vin,
    required this.unitNumber,
    required this.license,
    required this.state,
    required this.color,
    required this.odometer,
    required this.driverType,
    required this.drivable,
    required this.haskey,
    required this.keyLocation,
    required this.addCallId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        year: json["year"] ?? "",
        make: json["make"] ?? "",
        model: json["model"] ?? "",
        type: json["type"] ?? "",
        vin: json["vin"] ?? "",
        unitNumber: json["unit_number"] ?? "",
        license: json["license"] ?? "",
        state: json["state"] ?? "",
        color: json["color"] ?? "",
        odometer: json["odometer"] ?? "",
        driverType: json["driver_type"] ?? "",
        drivable: json["drivable"] ?? "",
        haskey: json["haskey"] ?? "",
        keyLocation: json["key_location"] ?? "",
        addCallId: json["add_call_id"] ?? 0,
        createdAt: _parseDateTime(json["created_at"]),
        updatedAt: _parseDateTime(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "year": year,
        "make": make,
        "model": model,
        "type": type,
        "vin": vin,
        "unit_number": unitNumber,
        "license": license,
        "state": state,
        "color": color,
        "odometer": odometer,
        "driver_type": driverType,
        "drivable": drivable,
        "haskey": haskey,
        "key_location": keyLocation,
        "add_call_id": addCallId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

DateTime _parseDateTime(dynamic input) {
  if (input == null) {
    return DateTime.now(); // Provide a default date if it's null
  }
  try {
    return DateTime.parse(input);
  } catch (e) {
    print("Error parsing date: $e");
    return DateTime.now(); // Provide a default date if parsing fails
  }
}
