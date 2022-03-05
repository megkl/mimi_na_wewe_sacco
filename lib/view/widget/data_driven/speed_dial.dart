import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/add_profile.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/add_user.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/profile.dart';

import '../../../data/repository/product/product_repository.dart';
import '../../../data/repository/user/user_repository.dart';
import '../../feature/authentication/authentication.dart';
import '../../feature/product/add_product.dart';
import '../../feature/product/product_bloc.dart';
import '../widgets.dart';

class SpeedDialWidget extends StatefulWidget {
  SpeedDialWidget({Key? key, this.username}) : super(key: key);
  String? username;
  @override
  _SpeedDialWidgetState createState() => _SpeedDialWidgetState();
}

class _SpeedDialWidgetState extends State<SpeedDialWidget> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        icon: Icons.add,
        backgroundColor: kPrimaryColor,
        overlayOpacity: 1,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.creditCard, color: Colors.white),
            label: 'Add Product',
            backgroundColor: kPrimaryColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider<ProductBloc>(
                            create: (context) => ProductBloc(
                              productRepository:
                                  RepositoryProvider.of<ProductRepository>(
                                      context),
                              authenticationBloc:
                                  BlocProvider.of<AuthenticationBloc>(context),
                            ),
                            child: AddProductScreen(),
                          )));
            },
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.university, color: Colors.white),
            label: 'Add User',
            backgroundColor: kPrimaryColor,
            // labelBackgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider<ProfileBloc>(
                            create: (context) => ProfileBloc(
                              userRepository:
                                  RepositoryProvider.of<UserRepository>(
                                      context),
                              authenticationBloc:
                                  BlocProvider.of<AuthenticationBloc>(context),
                            ),
                            child: AddUserScreen(
                              username: widget.username,
                            ),
                          )));
            },
          ),
        ]);
  }
}
