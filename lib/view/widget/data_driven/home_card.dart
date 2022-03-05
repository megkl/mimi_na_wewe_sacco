import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimi_na_wewe_sacco/view/widget/widgets.dart';

class HomeCard extends StatefulWidget {
  final String name;
  final IconData selectedIcon;
  final String unselectedIcon;
  final bool isSelected;

  HomeCard(
      {Key? key,
      required this.name,
      required this.selectedIcon,
      required this.unselectedIcon,
      required this.isSelected})
      : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getProportionalScreenWidth(4),
          vertical: getProportionalScreenHeight(10)),
      width: getProportionalScreenWidth(200),
      height: getProportionalScreenHeight(500),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(31, 241, 199, 199),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(getProportionalScreenWidth(10)),
          //color: widget.isSelected ? kPrimaryColor : kWhiteColor),
          color: kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.selectedIcon,
            color: kPrimaryColor,
          ),
          SizedBox(
            height: getProportionalScreenHeight(20),
          ),
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: getProportionalScreenHeight(13),
                fontWeight: FontWeight.w700,
                color: kBlackColor),
          ),
        ],
      ),
    );
  }
}

class HomeModel {
  String name;
  IconData selectedIcon;
  String unselectedIcon;

  HomeModel(this.name, this.selectedIcon, this.unselectedIcon);
}

List<HomeModel> menu = HomeData.map((Map<dynamic, dynamic> item) =>
        HomeModel(item['name'], item['selectedIcon'], item['unselectedIcon']))
    .toList();

var HomeData = [
  {
    "name": "Products",
    "selectedIcon": Icons.book,
    "unselectedIcon": "assets/svg/money_transfer_blue.svg"
  },
  {
    "name": "Loans",
    "selectedIcon": FontAwesomeIcons.moneyBillWaveAlt,
    "unselectedIcon": "assets/svg/bank_withdraw_blue.svg"
  },
  {
    "name": "My Profile",
    "selectedIcon": Icons.person,
    "unselectedIcon": "assets/svg/insight_tracking_blue.svg"
  },
  {
    "name": "My Dreams",
    "selectedIcon": FontAwesomeIcons.lightbulb,
    "unselectedIcon": "assets/svg/money_transfer_blue.svg"
  },
  {
    "name": "Info",
    "selectedIcon": Icons.inbox,
    "unselectedIcon": "assets/svg/bank_withdraw_blue.svg"
  },
  {
    "name": "Messages",
    "selectedIcon": Icons.message_sharp,
    "unselectedIcon": "assets/svg/insight_tracking_blue.svg"
  },
];

List<HomeModel> sendMoneyMenus = HomeData.map((Map<dynamic, dynamic> item) =>
        HomeModel(item['name'], item['selectedIcon'], item['unselectedIcon']))
    .toList();

var sendMoneyMenusData = [
  {
    "name": "Send Money",
    "selectedIcon": Icons.send,
    "unselectedIcon": "assets/svg/money_transfer_blue.svg"
  },
  {
    "name": "Load Cash",
    "selectedIcon": FontAwesomeIcons.moneyBillWaveAlt,
    "unselectedIcon": "assets/svg/bank_withdraw_blue.svg"
  },
  {
    "name": "Buy Airtime",
    "selectedIcon": FontAwesomeIcons.moneyCheckAlt,
    "unselectedIcon": "assets/svg/insight_tracking_blue.svg"
  },
  {
    "name": "Pay Goods & Services",
    "selectedIcon": FontAwesomeIcons.mailBulk,
    "unselectedIcon": "assets/svg/money_transfer_blue.svg"
  },
  {
    "name": "Xpress",
    "selectedIcon": FontAwesomeIcons.lightbulb,
    "unselectedIcon": "assets/svg/bank_withdraw_blue.svg"
  },
  {
    "name": "Check Balance",
    "selectedIcon": FontAwesomeIcons.cashRegister,
    "unselectedIcon": "assets/svg/insight_tracking_blue.svg"
  },
];
