import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication.dart';
import 'sign_up.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository? userRepository;
  final AuthenticationBloc? authenticationBloc;

  SignUpBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(SignUpInitialState()) {
    on<SignUpPressed>((event, emit) async {
      emit(SignUpProcessingState());
      try {
        await userRepository!.signUp(
          emailAddress: event.emailAddress,
          phoneNumber: event.phoneNumber,
          registrationType: event.registrationType,
          location: event.userLocation,
          password: event.password,
          socialId: event.socialId,
          isAdmin: event.isAdmin,
          isVerified: event.isVerified,
          username: event.username,
        );
        emit(SignUpFinishedState());
      } catch (error) {
        emit(SignUpErrorState(error.toString()));
      }
    });
  }
}
