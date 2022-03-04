import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInPressed extends SignInEvent {
  final String? username;
  final String? phoneNumber;
  final String? emailAddress;
  final String? password;
  final bool? isVerified;
  final bool? isAdmin;
  final String? userLocation;

  SignInPressed({
    this.username,
    this.phoneNumber,
    this.emailAddress,
    this.password,
    this.isAdmin,
    this.isVerified,
    this.userLocation,
  });

  @override
  List<Object> get props => [
        username.toString(),
        phoneNumber.toString(),
        emailAddress.toString(),
        password.toString(),
        isAdmin.toString(),
        isVerified.toString(),
        userLocation.toString(),
      ];
}
