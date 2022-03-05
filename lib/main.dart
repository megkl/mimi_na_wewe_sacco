// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mimi_na_wewe_sacco/data/repository/product/product_repository.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication_event.dart';
import 'package:mimi_na_wewe_sacco/view/feature/home/homepage.dart';
import 'package:mimi_na_wewe_sacco/view/feature/product/product_list.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/add_profile.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/profile.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_in/sign_In.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_in/sign_in_with_email.dart';
import 'config/routes.dart';
import 'data/repository/user/user_repository.dart';
import 'domain/locator.dart' as service_locator;
import 'domain/locator.dart';
import 'view/feature/authentication/authentication_bloc.dart';
import 'view/feature/authentication/authentication_state.dart';
import 'view/feature/product/add_product.dart';
import 'view/feature/product/product.dart';
import 'view/feature/sign_up/sign_up_bloc.dart';
import 'view/feature/sign_up/sign_up_tab.dart';
import 'view/feature/splash/splash_screen.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}

void main() async {
  service_locator.init();

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_KE',
    supportedLocales: ['en_KE', 'en_US'],
  );

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Bloc.observer = SimpleBlocDelegate();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => sl(),
          ),
          RepositoryProvider<ProductRepository>(
            create: (context) => sl(),
          ),
        ],
        child: LocalizedApp(
          delegate,
          MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate,
          ],
          routes: _registerRoutes(),
          onGenerateRoute: _registerRoutesWithParameters,
          supportedLocales: localizationDelegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          locale: localizationDelegate.currentLocale,
          title: 'Mimi na Wewe Sacco',
          theme: ThemeData(),
        ));
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      MimiNaWeweSacco.signupwithphone: (context) => _buildSignUpBloc(),
      MimiNaWeweSacco.signupwithemail: (context) => _buildSignUpBloc(),
      MimiNaWeweSacco.signinwithemail: (context) => _buildSignInBloc(),
      MimiNaWeweSacco.editProduct: (context) => _buildSignUpBloc(),
      MimiNaWeweSacco.addProfile: (context) => _buildAddProfile(),
      MimiNaWeweSacco.profile: (context) => _buildSignUpBloc(),
      MimiNaWeweSacco.addProduct: (context) => _buildAddProductBloc(),
      MimiNaWeweSacco.productList: (context) => _buildProductListBloc(),
      MimiNaWeweSacco.editProfile: (context) => _buildSignUpBloc(),
      MimiNaWeweSacco.home: (context) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is Authenticated) {
              return _buildSignInBloc(); //TODO profile properties should be here
            } else if (state is LogInUnauthenticated) {
              return _buildSignInBloc();
            } else if (state is ProfileUnauthenticated) {
              return _buildAddProfile();
            } else if (state is CodeUnauthenticated) {
              //return _buildSetPinBloc();
            } else if (state is SignUpUnauthenticated) {
              return _buildSignUpBloc();
            } else {
              return SplashScreen();
            }
          }),
    };
  }

  BlocProvider<SignInBloc> _buildSignInBloc() {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: const SignInWithEmailScreen(),
    );
  }

  BlocProvider<SignUpBloc> _buildSignUpBloc() {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: SignUpTab(),
    );
  }

  BlocProvider<ProductBloc> _buildAddProductBloc() {
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(
        productRepository: RepositoryProvider.of<ProductRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: AddProductScreen(),
    );
  }

  BlocProvider<ProductBloc> _buildProductListBloc() {
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(
        productRepository: RepositoryProvider.of<ProductRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: ProductListScreen(),
    );
  }

  BlocProvider<ProfileBloc> _buildAddProfile() {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: AddProfileScreen(),
    );
  }

  Route _registerRoutesWithParameters(RouteSettings settings) {
    if (settings.name == MimiNaWeweSacco.editProfile) {
      //final ProfileEntity editProfileParameters = settings.arguments;
      return MaterialPageRoute(builder: (context) {
        // return EditProfileScreen(
        //   profileEntity: editProfileParameters,
        // );
      });
    }
  }
}
