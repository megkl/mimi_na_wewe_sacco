import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class LogInUnauthenticated extends AuthenticationState {}

class SignUpUnauthenticated extends AuthenticationState {}

class ProfileUnauthenticated extends AuthenticationState {}

class CodeUnauthenticated extends AuthenticationState {}
