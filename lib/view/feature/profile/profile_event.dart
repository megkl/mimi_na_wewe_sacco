import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfilePressed extends ProfileEvent {
  final String? email;
  final String? firstName;
  final String? middleName;
  final String? username;
  final String? lastName;
  final String? idNumber;
  final bool? isAdmin;
  final String? country;
  final String? phoneNumber;
  final String? location;

  ProfilePressed(
      {this.email,
      this.firstName,
      this.username,
      this.phoneNumber,
      this.middleName,
      this.country,
      this.idNumber,
      this.isAdmin,
      this.location,
      this.lastName});

  @override
  List<Object> get props => [
        email.toString(),
        firstName.toString(),
        phoneNumber.toString(),
        username.toString(),
        middleName.toString(),
        lastName.toString(),
        idNumber.toString(),
        isAdmin.toString(),
        country.toString(),
        location.toString(),
      ];
}

class EditProfilePressed extends ProfileEvent {
  final String? email;
  final String? firstName;
  final String? username;
  final String? phoneNumber;
  final String? middleName;
  final String? lastName;
  final String? idNumber;
  final bool? isAdmin;
  final String? country;
  final String? location;

  EditProfilePressed(
      {this.email,
      this.phoneNumber,
      this.firstName,
      this.middleName,
      this.username,
      this.country,
      this.idNumber,
      this.isAdmin,
      this.lastName,
      this.location});

  @override
  List<Object> get props => [
        email.toString(),
        firstName.toString(),
        middleName.toString(),
        lastName.toString(),
        username.toString(),
        idNumber.toString(),
        isAdmin.toString(),
        country.toString(),
        location.toString()
      ];
}

class ShowProfilePressed extends ProfileEvent {
  final String? username;
  ShowProfilePressed({this.username});

  @override
  List<Object> get props => [];
}
