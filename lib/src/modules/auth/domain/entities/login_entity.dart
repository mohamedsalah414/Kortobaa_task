import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final  String? refresh;
  final String? access;

  const LoginEntity({
    this.refresh,
    this.access,
  });

  @override
  List<Object?> get props => [refresh, access];
}