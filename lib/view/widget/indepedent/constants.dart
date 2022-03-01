import 'package:flutter/material.dart';

import 'size_config.dart';

//color configs
const kPrimaryColor = Color(0xFF5271FF);
const kBackgroundColor = Color(0xFFFFFFFF);
const kPrimaryTextColor = Color(0xFF000000);
const kSecondaryTextColor = Color(0xFF5271FF);
const kSecondaryColor = Color(0xFF1443C3);
const kSliderColor = Color(0xFFEBEEFC);
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black;

//gradient color
const kPrimaryGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1443C3), Color(0xFF5271FF)]);

//spacing configs
const defaultPadding = 10.0;

//custom errors
const emailError = 'Enter a valid email address';
const requiredField = 'This field is required';

const kAnimationDuration = Duration(milliseconds: 200);

var subHeadingtextStyle = TextStyle(
  color: kBackgroundColor,
  fontSize: getProportionalScreenHeight(17),
  fontWeight: FontWeight.bold,
);
const headingWhiteTextStyle = TextStyle(
  color: kBackgroundColor,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);
var bluetextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: getProportionalScreenHeight(16),
  fontWeight: FontWeight.bold,
);

var headingtextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: getProportionalScreenHeight(20),
  fontWeight: FontWeight.bold,
);

var textStyle = TextStyle(
    color: kPrimaryTextColor,
    fontSize: getProportionalScreenHeight(16),
    fontWeight: FontWeight.normal);

var boldStyle = TextStyle(
    color: kPrimaryTextColor,
    fontSize: getProportionalScreenHeight(18),
    fontWeight: FontWeight.normal);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: getProportionalScreenWidth(15)),
    border: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    enabledBorder: outlineInputBorder(),
    focusColor: kPrimaryColor);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionalScreenWidth(15)),
    borderSide: BorderSide(color: kPrimaryColor),
  );
}
