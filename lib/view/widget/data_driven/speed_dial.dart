import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mimi_na_wewe_sacco/config/routes.dart';

import '../widgets.dart';

class SpeedDialWidget extends StatefulWidget {
  const SpeedDialWidget({Key? key}) : super(key: key);

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
              Navigator.of(context).pushNamedAndRemoveUntil(
                MimiNaWeweSacco.addProduct,
                (Route<dynamic> route) => false,
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.university, color: Colors.white),
            label: 'Add User',
            backgroundColor: kPrimaryColor,
            // labelBackgroundColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                MimiNaWeweSacco.addUser,
                (Route<dynamic> route) => false,
              );
            },
          ),
        ]);
  }
}
