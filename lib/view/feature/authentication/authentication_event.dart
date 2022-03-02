import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  // String? token;
  // AppStarted(this.token);

  // @override
  // List<Object> get props => [token!];
}

class SignedUp extends AuthenticationEvent {
  String token;
  String refreshToken;
  String userId;
  SignedUp(this.token, this.refreshToken, this.userId);

  @override
  List<Object> get props => [token, refreshToken, userId];
}

class ProfileCreated extends AuthenticationEvent {
  String firstName;
  String idNumber;
  ProfileCreated(
    this.firstName,
    this.idNumber,
  );

  @override
  List<Object> get props => [firstName, idNumber];
}

class PinCreated extends AuthenticationEvent {
  String pin;
  PinCreated(this.pin);

  @override
  List<Object> get props => [pin];
}

class LoggedIn extends AuthenticationEvent {
  String token;
  String refreshToken;
  String userId;
  LoggedIn(this.token, this.refreshToken, this.userId);

  @override
  List<Object> get props => [token, refreshToken, userId];
}

class LoggedOut extends AuthenticationEvent {
  // String refreshToken;
  // String userId;
  // LoggedOut(this.refreshToken, this.userId);

  // @override
  // List<Object> get props => [refreshToken, userId];
}
