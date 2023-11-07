import 'dart:convert';

import 'package:krtobaa_task/src/modules/auth/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    User? user,
    String? message,
  }) : super(
          message: message,
    user: user,
        );

  factory RegisterModel.fromRawJson(String str) =>
      RegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
class UserModel extends User{
  const UserModel({
    int? id,
    dynamic? lastLogin,
    bool? isSuperuser,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    bool? isStaff,
    bool? isActive,
    DateTime? dateJoined,
    List<dynamic>? groups,
    List<dynamic>? userPermissions,
  }) : super(
    id: id,
    lastLogin: lastLogin,
    isSuperuser: isSuperuser,
    username: username,
    firstName: firstName,
    lastName: lastName,
    email: email,
    isStaff: isStaff,
    isActive: isActive,
    dateJoined: dateJoined,
    groups: groups,
    userPermissions: userPermissions,
  );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    lastLogin: json["last_login"],
    isSuperuser: json["is_superuser"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: DateTime.parse(json["date_joined"]),
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin,
    "is_superuser": isSuperuser,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "is_staff": isStaff,
    "is_active": isActive,
    "date_joined": dateJoined!.toIso8601String(),
    "groups": List<dynamic>.from(groups!.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions!.map((x) => x)),
  };
}