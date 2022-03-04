import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpPressed extends SignUpEvent {
  final String? username;
  final String? phoneNumber;
  final String? emailAddress;
  final String? password;
  final String? registrationType;
  final String? socialId;
  final bool? isVerified;
  final bool? isAdmin;
  final String? userLocation;

  SignUpPressed(
      {this.username,
      this.phoneNumber,
      this.emailAddress,
      this.password,
      this.registrationType,
      this.isAdmin,
      this.isVerified,
      this.userLocation,
      this.socialId});

  @override
  List<Object> get props => [
        username.toString(),
        phoneNumber.toString(),
        emailAddress.toString(),
        password.toString(),
        registrationType.toString(),
        isAdmin.toString(),
        isVerified.toString(),
        userLocation.toString(),
        socialId.toString()
      ];
}
