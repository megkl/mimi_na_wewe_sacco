import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_na_wewe_sacco/config/storage.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication_bloc.dart';
import 'profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository? userRepository;
  final AuthenticationBloc? authenticationBloc;
  // final ProfileRepository? profileRepository;

  ProfileBloc({this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(ProfileInitialState()) {
    on<ProfilePressed>((event, emit) async {
      emit(ProfileProcessingState());
      try {
        await userRepository!.updateProfile(
            email: event.email,
            phoneNumber: event.phoneNumber,
            username: event.username,
            firstName: event.firstName,
            middleName: event.middleName,
            lastName: event.lastName,
            idNumber: event.idNumber,
            isAdmin: event.isAdmin,
            location: event.country);
        // authenticationBloc.add(LoggedIn(token));
        emit(ProfileFinishedState());
      } catch (error) {
        emit(ProfileErrorState(error.toString()));
      }
    });

    on<EditProfilePressed>((event, emit) async {
      emit(ProfileProcessingState());
      try {
        await userRepository!.updateProfile(
            email: event.email,
            firstName: event.firstName,
            username: event.username,
            middleName: event.middleName,
            phoneNumber: event.phoneNumber,
            lastName: event.lastName,
            idNumber: event.idNumber,
            isAdmin: event.isAdmin,
            location: event.country);
        // authenticationBloc.add(LoggedIn(token));
        emit(ProfileFinishedState());
      } catch (error) {
        emit(ProfileErrorState(error.toString()));
      }
    });

    on<ShowProfilePressed>((event, emit) async {
      emit(ProfileProcessingState());
      try {
        final ProfileEntity? profile =
            await userRepository!.fetchProfile(event.username);
        emit(ProfileLoaded(profileEntity: profile));
      } catch (error) {
        emit(ProfileErrorState(error.toString()));
      }
    });
  }
}
