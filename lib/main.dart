// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication_event.dart';
import 'config/routes.dart';
import 'data/repository/user/user_repository.dart';
import 'domain/locator.dart' as service_locator;
import 'domain/locator.dart';
import 'view/feature/authentication/authentication_bloc.dart';
import 'view/feature/authentication/authentication_state.dart';

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
          title: 'Pesabank',
          theme: ThemeData(),
        ));
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      //PesaBankRoutes.signupwithphone: (context) => _buildSignUpPhoneBloc(),
      //PesaBankRoutes.signupwithemail: (context) => _buildSignUpEmailBloc(),
      //PesaBankRoutes.signinwithemail: (context) => _buildSignInEmailBloc(),
      //PesaBankRoutes.signinwithphone: (context) => _buildSignInPhoneBloc(),
      //PesaBankRoutes.signUpverificationCode: (context) =>
      //_buildSignUpVerificationCodeBloc(),
      //PesaBankRoutes.addprofile: (context) => _buildaddProfileBloc(),
      // PesaBankRoutes.profile: (context) => _buildProfileBloc(),
      //   PesaBankRoutes.addcard: (context) => _buildAddCardBloc(),
      //   PesaBankRoutes.cardList: (context) => _buildCardList(),
      //   PesaBankRoutes.editprofile: (context) => _buildeditProfileBloc(),
      //   PesaBankRoutes.home: (context) =>
      //       BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //           builder: (context, state) {
      //         if (state is Authenticated) {
      //           //return HomePage(); //TODO profile properties should be here
      //         } else if (state is LogInUnauthenticated) {
      //           //return const AccountScreen();
      //         } else if (state is ProfileUnauthenticated) {
      //           //return _buildaddProfileBloc();
      //         } else if (state is CodeUnauthenticated) {
      //           //return _buildSetPinBloc();
      //         } else if (state is SignUpUnauthenticated) {
      //           //return OnBoarding();
      //         } else {
      //           //return SplashScreen();
      //         }
      //       }),
      //   // PesaBankRoutes.profile: (context) =>
      //   //     BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   //         builder: (context, state) {
      //   //       //TODO: revise authentication later. Right now no login is required.
      //   //       if (state is Authenticated) {
      //   //         // return HomeScreen(); //TODO profile properties should be here
      //   //       } else if (state is Unauthenticated) {
      //   //         return _buildSignInBloc();
      //   //       } else {
      //   //         return SplashScreen();
      //   //       }
      //   //     }),
    };
  }

  // BlocProvider<SignInBloc> _buildSignInEmailBloc() {
  //   return BlocProvider<SignInBloc>(
  //     create: (context) => SignInBloc(
  //       userRepository: RepositoryProvider.of<UserRepository>(context),
  //       authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
  //     ),
  //     child: SignInEmailScreen(),
  //   );
  // }

  // BlocProvider<SignInBloc> _buildSignInPhoneBloc() {
  //   return BlocProvider<SignInBloc>(
  //     create: (context) => SignInBloc(
  //       userRepository: RepositoryProvider.of<UserRepository>(context),
  //       authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
  //     ),
  //     child: SignInPhoneScreen(),
  //   );
  // }

  // BlocProvider<SignUpBloc> _buildSignUpEmailBloc() {
  //   return BlocProvider<SignUpBloc>(
  //       create: (context) => SignUpBloc(
  //             userRepository: RepositoryProvider.of<UserRepository>(context),
  //             authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
  //           ),
  //       child: SignUpEmailScreen());
  // }

  // BlocProvider<SignUpBloc> _buildSignUpPhoneBloc() {
  //   return BlocProvider<SignUpBloc>(
  //       create: (context) => SignUpBloc(
  //             userRepository: RepositoryProvider.of<UserRepository>(context),
  //             authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
  //           ),
  //       child: SignUpPhoneScreen());
  // }
  Route _registerRoutesWithParameters(RouteSettings settings) {
    if (settings.name == PesaBankRoutes.editprofile) {
      //final ProfileEntity editProfileParameters = settings.arguments;
      return MaterialPageRoute(builder: (context) {
        // return EditProfileScreen(
        //   profileEntity: editProfileParameters,
        // );
      });
    }
  }
}
