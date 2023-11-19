
import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  int status;
  List<Employee> employees;

  UserListModel({
    required this.status,
    required this.employees,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    status: json["status"],
    employees: List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
  };
}

class Employee {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  int roleId;
  dynamic ownerId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.ownerId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    roleId: json["role_id"],
    ownerId: json["owner_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "role_id": roleId,
    "owner_id": ownerId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}