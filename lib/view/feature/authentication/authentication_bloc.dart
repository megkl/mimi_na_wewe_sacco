import 'package:bloc/bloc.dart';
import 'package:mimi_na_wewe_sacco/config/storage.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_api_handler.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Uninitialized()) {
    on<AppStarted>((event, emit) async {
      var token = await _getToken();
      var refreshToken = await _getRefreshToken();
      var userId = await _getUserId();

      if (token != '' && refreshToken != '') {
        var newToken = await _getNewToken(refreshToken);

        token = newToken['token'];
        Storage().storage['token'] = token;
        await _saveToken(token);

        Storage().storage['refreshToken'] = refreshToken;
        Storage().storage['userId'] = userId;

        final ProfileEntity? profile = await UserApiHandler().fetchProfile();

        if (profile!.firstName == null || profile.idNumber == null) {
          emit(ProfileUnauthenticated());
        } else if (profile.isVerified == false) {
          emit(CodeUnauthenticated());
        } else {
          emit(Authenticated());
        }
      } else if (token != '' && refreshToken == '') {
        emit(LogInUnauthenticated());
      } else {
        emit(SignUpUnauthenticated());
      }
    });

    on<SignedUp>((event, emit) async {
      Storage().storage['token'] = event.token;
      Storage().storage['refreshToken'] = event.refreshToken;
      Storage().storage['userId'] = event.userId;

      await _saveToken(event.token);
      await _saveRefreshToken(event.refreshToken);
      await _saverUserId(event.userId);

      emit(Authenticated());
    });

    on<LoggedIn>((event, emit) async {
      Storage().storage['token'] = event.token;
      Storage().storage['refreshToken'] = event.refreshToken;
      Storage().storage['userId'] = event.userId;

      await _saveToken(event.token);
      await _saveRefreshToken(event.refreshToken);
      await _saverUserId(event.userId);

      emit(Authenticated());
    });

    on<LoggedOut>((event, emit) async {
      await UserApiHandler().logout(
        userId: Storage().storage['userId'],
        refreshToken: Storage().storage['token'],
      );
      await _deleteToken();
      emit(LogInUnauthenticated());
    });
  }

  /// delete from keystore/keychain
  Future<void> _deleteToken() async {
    await Storage().secureStorage.delete(key: 'refreshToken');
  }

  /// write to keystore/keychain
  Future<void> _saveToken(String token) async {
    await Storage().secureStorage.write(key: 'token', value: token);
  }

  /// write to keystore/keychain
  Future<void> _saveRefreshToken(String refreshToken) async {
    await Storage()
        .secureStorage
        .write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> _saverUserId(String userId) async {
    await Storage().secureStorage.write(key: 'userId', value: userId);
  }

  /// read to keystore/keychain
  Future<String> _getToken() async {
    return await Storage().secureStorage.read(key: 'token') ?? '';
  }

  /// read to keystore/keychain
  Future<String> _getRefreshToken() async {
    return await Storage().secureStorage.read(key: 'refreshToken') ?? '';
  }

  Future<String> _getUserId() async {
    return await Storage().secureStorage.read(key: 'userId') ?? '';
  }

  Future<Map<String, dynamic>> _getNewToken(String? token) async {
    return await UserApiHandler().refreshToken(refreshToken: token);
  }
}
