import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_up/sign_up.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_up/sign_up_with_email.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_up/sign_up_with_phone.dart';
import 'package:mimi_na_wewe_sacco/view/widget/indepedent/constants.dart';

class SignUpTab extends StatefulWidget {
  const SignUpTab({Key? key}) : super(key: key);

  @override
  _SignUpTabState createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab>
    with SingleTickerProviderStateMixin {
  late TabController? _controller;

  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(FontAwesomeIcons.envelope), text: "Email"),
    Tab(icon: Icon(FontAwesomeIcons.mobileAlt), text: "Phone Number"),
  ];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: list.length, vsync: this);
    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: kPrimaryColor,
          //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Sign Up"),
          centerTitle: true,
          bottom: TabBar(
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              controller: _controller,
              tabs: list),
          // leading: IconButton(
          //   icon: Icon(FontAwesomeIcons.arrowAltCircleLeft),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ),
        backgroundColor: kBackgroundColor,
        body: DefaultTabController(
          length: 2,
          child: TabBarView(
            controller: _controller,
            children: [
              BlocProvider<SignUpBloc>(
                  create: (context) => SignUpBloc(
                        userRepository:
                            RepositoryProvider.of<UserRepository>(context),
                        authenticationBloc:
                            BlocProvider.of<AuthenticationBloc>(context),
                      ),
                  child: SignUpWithEmailScreen()),
              BlocProvider<SignUpBloc>(
                  create: (context) => SignUpBloc(
                        userRepository:
                            RepositoryProvider.of<UserRepository>(context),
                        authenticationBloc:
                            BlocProvider.of<AuthenticationBloc>(context),
                      ),
                  child: SignUpWithPhoneScreen()),
            ],
          ),
        ));
  }
}
