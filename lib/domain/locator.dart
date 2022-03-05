import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mimi_na_wewe_sacco/data/network/network_status.dart';
import 'package:mimi_na_wewe_sacco/data/repository/product/product_api_handler.dart';
import 'package:mimi_na_wewe_sacco/data/repository/product/product_repository.dart';
import 'package:mimi_na_wewe_sacco/data/repository/product/product_repository_impl.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_api_handler.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository_impl.dart';

final sl = GetIt.instance;

//Service locator description
void init() {
  //Singleton for NetworkStatus identification
  sl.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImpl(DataConnectionChecker()));

  // //get home page products use case
  // sl.registerLazySingleton<GetHomePageProductsUseCase>(
  //     () => GetHomePageProductsUseCaseImpl());

  sl.registerLazySingleton<UserApiHandler>(
    () => UserApiHandler(),
  );
  sl.registerLazySingleton<ProductApiHandler>(
    () => ProductApiHandler(),
  );
  // sl.registerLazySingleton<ProfileApiHandler>(
  //   () => ProfileApiHandler(),
  // );
  // sl.registerLazySingleton<ProductApiHandler>(
  //   () => CardApiHandler(),
  // );
  // sl.registerLazySingleton<BankAccountApiHandler>(
  //   () => ProductApiHandler(),
  //);

  // sl.registerLazySingleton<SignInBloc>(
  //   () => SignInBloc(),
  // );

  //Singleton for HTTP request
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userApiHandler: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(productApiHandler: sl()),
  );

  // sl.registerLazySingleton<ProfileRepository>(
  //   () => ProfileRepositoryImpl(apiHandler: sl()),
  // );

  // sl.registerLazySingleton<ProductRepository>(
  //   () => ProductRepositoryImpl(cardApiHandler: sl()),
  // );
}
