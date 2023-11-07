import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final User? user;
  final String? message;

  const RegisterEntity({
    this.user,
    this.message,
  });

  @override
  List<Object?> get props => [user, message];

}

class User extends Equatable {
  final int? id;
  final dynamic? lastLogin;
  final bool? isSuperuser;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isStaff;
  final bool? isActive;
  final DateTime? dateJoined;
  final List<dynamic>? groups;
  final List<dynamic>? userPermissions;

  const User({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.groups,
    this.userPermissions,
  });

  @override
  List<Object?> get props => [
        id,
        lastLogin,
        isSuperuser,
        username,
        firstName,
        lastName,
        email,
        isStaff,
        isActive,
        dateJoined,
        groups,
        userPermissions
      ];
}
