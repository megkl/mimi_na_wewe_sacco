import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInPressed extends SignInEvent {
  final String? username;
  final String? password;

  SignInPressed({
    this.username,
    this.password,
  });

  @override
  List<Object> get props => [
        username.toString(),
        password.toString(),
      ];
}
