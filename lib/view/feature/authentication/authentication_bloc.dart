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
      //var token = await _getToken();
      var token = await _getToken();
      if (token != '') {
        Storage().token = token;
        emit(Authenticated());
      } else {
        emit(SignUpUnauthenticated());
      }
    });

    on<SignedUp>((event, emit) async {
      Storage().token = event.token;
      await _saveToken(event.token);
      emit(Authenticated());
    });

    on<LoggedIn>((event, emit) async {
      Storage().token = event.token;
      await _saveToken(event.token);
      emit(Authenticated());
    });

    on<LoggedOut>((event, emit) async {
      await UserApiHandler().logout(
        //userId: Storage().storage['_id'],
        refreshToken: Storage().token,
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
    await Storage().secureStorage.write(key: '_d', value: userId);
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
    return await Storage().secureStorage.read(key: '_id') ?? '';
  }

  Future<Map<String, dynamic>> _getNewToken(String? token) async {
    return await UserApiHandler().refreshToken(refreshToken: token);
  }
}
