import 'package:equatable/equatable.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileProcessingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class ProfileEmpty extends ProfileState {}

class ProfileFinishedState extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity? profileEntity;

  ProfileLoaded({this.profileEntity});

  @override
  List<Object> get props => [profileEntity!];
}
