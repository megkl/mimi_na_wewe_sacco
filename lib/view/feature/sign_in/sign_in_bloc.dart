import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication.dart';
import 'sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository? userRepository;
  final AuthenticationBloc? authenticationBloc;

  SignInBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(SignInInitialState()) {
    on<SignInPressed>((event, emit) async {
      emit(SignInProcessingState());
      try {
        await userRepository!.signIn(
            emailAddress: event.emailAddress,
            phoneNumber: event.phoneNumber,
            userLocation: event.userLocation,
            password: event.password,
            isAdmin: event.isAdmin,
            isVerified: event.isVerified,
            username: event.username);
        emit(SignInFinishedState());
      } catch (error) {
        emit(SignInErrorState(error.toString()));
      }
    });
  }
}
