import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/domain/model/user_entity.dart';

import '../widgets.dart';

class UserContainer extends StatefulWidget {
  const UserContainer({Key? key, this.userEntity, this.index})
      : super(key: key);
  final ProfileEntity? userEntity;
  final int? index;
  @override
  _UserContainerState createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionalScreenHeight(150),
      margin: EdgeInsets.only(bottom: getProportionalScreenHeight(15)),
      padding: EdgeInsets.only(
          left: getProportionalScreenHeight(20),
          right: getProportionalScreenHeight(22)),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(getProportionalScreenHeight(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(8.0, 8.0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: getProportionalScreenHeight(60),
                width: getProportionalScreenWidth(60),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://res.cloudinary.com/pesabank-limited/image/upload/v1644301001/debit-card_yjong0.png"),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionalScreenWidth(13),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "First Name: ${widget.userEntity!.firstName!}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(18),
                        fontWeight: FontWeight.w700,
                        color: kBlackColor),
                  ),
                  SizedBox(height: getProportionalScreenHeight(5)),
                  Text(
                    "Last Name: ${widget.userEntity!.lastName}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(15),
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: getProportionalScreenHeight(5)),
                  Text(
                    "Email Address: ${widget.userEntity!.emailAddress}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(15),
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: getProportionalScreenHeight(5)),
                  Text(
                    "Phone Number: ${widget.userEntity!.phoneNumber!}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(15),
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
