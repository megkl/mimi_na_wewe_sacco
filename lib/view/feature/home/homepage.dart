import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mimi_na_wewe_sacco/data/repository/product/product_repository.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication.dart';
import 'package:mimi_na_wewe_sacco/view/feature/product/product_bloc.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/profile.dart';
import 'package:mimi_na_wewe_sacco/view/widget/widgets.dart';

import '../profile/profile_screen.dart';
import 'home_screen.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key, this.username}) : super(key: key);
  String? username;
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String? _username;
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (BuildContext context) => ProductBloc(
              productRepository:
                  RepositoryProvider.of<ProductRepository>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            ),
          ),
          // BlocProvider<ProductBloc>(
          //   create: (BuildContext context) => ProductBloc(
          //     ProductRepository: RepositoryProvider.of<ProductRepository>(context),
          //     authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          //   ),
          // ),
        ],
        child: HomeScreen(username: widget.username),
      ),
      //const TransactionsScreen(),
      //const Accounts(),
      // BlocProvider<BankAccountBloc>(
      //     create: (context) => BankAccountBloc(
      //           bankAccountRepository:
      //               RepositoryProvider.of<BankAccountRepository>(context),
      //           authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      //         ),
      //     child: BankAccountListScreen()),
      BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
              ),
          child: ProfileScreen(username: widget.username))
    ];

    return Scaffold(
        body: widgets[_currentIndex], bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.home),
          title: const Text('Home'),
          activeColor: kPrimaryColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        // BottomNavyBarItem(
        //   icon: const Icon(FontAwesomeIcons.exchangeAlt),
        //   title: const Text('Transactions'),
        //   activeColor: kPrimaryColor,
        //   inactiveColor: _inactiveColor,
        //   textAlign: TextAlign.center,
        // ),
        // BottomNavyBarItem(
        //   icon: const Icon(FontAwesomeIcons.chartLine),
        //   title: const Text(
        //     'Analytics ',
        //   ),
        //   activeColor: kPrimaryColor,
        //   inactiveColor: _inactiveColor,
        //   textAlign: TextAlign.center,
        // ),

        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.cogs),
          title: const Text('Profile'),
          activeColor: kPrimaryColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
