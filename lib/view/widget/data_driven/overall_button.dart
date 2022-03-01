import 'package:flutter/material.dart';

import '../widgets.dart';

class OverallButton extends StatelessWidget {
  const OverallButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(20)),
      child: SizedBox(
        width: double.infinity,
        height: getProportionalScreenHeight(56),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
          ),
          onPressed: press as void Function()?,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                fontSize: getProportionalScreenWidth(18),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(90)),
      child: SizedBox(
        width: getProportionalScreenHeight(200),
        height: getProportionalScreenHeight(50),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
          ),
          onPressed: press as void Function()?,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                fontSize: getProportionalScreenWidth(18),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
    this.text,
    this.press,
    this.icon,
    this.endIcon,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final IconData? icon;
  final IconData? endIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionalScreenHeight(55),
      child: Card(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(10)),
        color: kWhiteColor,
        elevation: getProportionalScreenHeight(5),
        shadowColor: kWhiteColor,
        child: SizedBox(
          width: double.infinity,
          height: getProportionalScreenHeight(45),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(getProportionalScreenWidth(25))),
              primary: kWhiteColor,
              //backgroundColor: kBackgroundColor,
            ),
            onPressed: press as void Function()?,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: getProportionalScreenHeight(20)),
                    Container(
                        height: getProportionalScreenHeight(30),
                        width: getProportionalScreenHeight(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: kPrimaryColor,
                          size: 20,
                        )),
                    SizedBox(width: getProportionalScreenHeight(20)),
                    Text(
                      text!,
                      style: TextStyle(
                        fontSize: getProportionalScreenWidth(17),
                        color: kBlackColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(endIcon, color: kBlackColor.withOpacity(0.5)),
                    SizedBox(width: getProportionalScreenHeight(10)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionDetailCard extends StatelessWidget {
  const TransactionDetailCard({
    Key? key,
    this.text,
    this.press,
    this.icon,
    this.endText,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final IconData? icon;
  final String? endText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionalScreenHeight(55),
      child: Card(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(10)),
        color: kWhiteColor,
        elevation: getProportionalScreenHeight(5),
        shadowColor: kWhiteColor,
        child: SizedBox(
          width: double.infinity,
          height: getProportionalScreenHeight(45),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(getProportionalScreenWidth(25))),
              primary: kWhiteColor,
              //backgroundColor: kBackgroundColor,
            ),
            onPressed: press as void Function()?,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: getProportionalScreenHeight(20)),
                    Container(
                        height: getProportionalScreenHeight(30),
                        width: getProportionalScreenHeight(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: kPrimaryColor,
                          size: 20,
                        )),
                    SizedBox(width: getProportionalScreenHeight(20)),
                    Text(
                      text!,
                      style: TextStyle(
                        fontSize: getProportionalScreenWidth(17),
                        color: kBlackColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      endText!,
                      style: textStyle,
                    ),
                    SizedBox(width: getProportionalScreenHeight(10)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountButton extends StatelessWidget {
  const AccountButton({
    Key? key,
    this.text,
    this.press,
    this.icon,
    this.endIcon,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final IconData? icon;
  final IconData? endIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: getProportionalScreenHeight(45),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            primary: kWhiteColor,
            backgroundColor: kPrimaryColor,
          ),
          onPressed: press as void Function()?,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: getProportionalScreenHeight(20)),
                  Icon(icon, color: kWhiteColor),
                  SizedBox(width: getProportionalScreenHeight(20)),
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: getProportionalScreenWidth(18),
                      color: kWhiteColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(endIcon, color: kWhiteColor.withOpacity(0.5)),
                  SizedBox(width: getProportionalScreenHeight(10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
