import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/validators/validator.dart';
import '../../../domain/model/profile_entity.dart';
import '../../widget/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  ProfileEntity profileEntity;

  EditProfileScreen({required this.profileEntity});
  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController idTypeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String idTypeSelectedValue = 'National_Id';

  final _formKey = GlobalKey<FormState>();

  late double sizeBetween;
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    setState(() {
      firstNameController.text = widget.profileEntity.firstName!;
      lastNameController.text = widget.profileEntity.lastName!;
      middleNameController.text = widget.profileEntity.middleName!;
      emailController.text = widget.profileEntity.emailAddress!;
      phoneNumberController.text = widget.profileEntity.phoneNumber!;
      idNumberController.text = widget.profileEntity.idNumber!;
      dobController.text = widget.profileEntity.dOB!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile Details',
            style: TextStyle(color: kWhiteColor),
          ),
          leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.arrowAltCircleLeft,
              color: kWhiteColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: kSecondaryColor,
          elevation: 0,
        ),
        backgroundColor: kBackgroundColor,
        body: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionalScreenWidth(20)),
              child: ListView(
                children: [
                  SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                  Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: SizeConfiguration.screenWidth * 0.8,
                            child: buildfirstNameFormField()),
                        SizedBox(height: getProportionalScreenHeight(20)),
                        SizedBox(
                            width: SizeConfiguration.screenWidth * 0.8,
                            child: buildmiddleNameFormField()),
                        SizedBox(height: getProportionalScreenHeight(20)),
                        SizedBox(
                            width: SizeConfiguration.screenWidth * 0.8,
                            child: buildLastNameFormField()),
                        SizedBox(height: getProportionalScreenHeight(20)),
                        SizedBox(
                            width: SizeConfiguration.screenWidth * 0.8,
                            child: buildEmailFormField()),
                        SizedBox(height: getProportionalScreenHeight(20)),
                        SizedBox(
                            width: SizeConfiguration.screenWidth * 0.8,
                            child: buildPhoneNumberFormField()),
                        SizedBox(height: getProportionalScreenHeight(20)),
                        SizedBox(
                            width: SizeConfiguration.screenWidth * 0.8,
                            child: buildIdNumberFormField()),
                        SizedBox(height: getProportionalScreenHeight(20)),
                        SizedBox(
                            width: SizeConfiguration.screenWidth * 0.8,
                            child: buildDobFormField()),
                        SizedBox(height: getProportionalScreenHeight(30)),
                        // OverallButton(
                        //     text: 'Edit Profile', press: _validateAndSend),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     _showSignUpWithPhone;
                  //   },
                  //   child: Text(
                  //     'Sign Up with Phone number instead',
                  //     style: TextStyle(color: kPrimaryColor),
                  //   ),
                  // ),
                  SizedBox(
                    height: sizeBetween,
                  ),
                ],
              ),
            )));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        controller: emailController,
        enabled: false,
        decoration: InputDecoration(
            labelText: "Email Address",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: const Icon(Icons.email, color: kPrimaryColor)));
  }

  TextFormField buildfirstNameFormField() {
    return TextFormField(
        controller: firstNameController,
        // validator: Validator.validateEmail,
        keyboardType: TextInputType.text,
        enabled: false,
        decoration: InputDecoration(
            labelText: "First Name",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildmiddleNameFormField() {
    return TextFormField(
        controller: middleNameController,
        enabled: false,
        decoration: InputDecoration(
            labelText: "Middle Name",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildIdNumberFormField() {
    return TextFormField(
        controller: idNumberController,
        keyboardType: TextInputType.text,
        enabled: false,
        decoration: InputDecoration(
            labelText: "Id Number",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
        controller: lastNameController,
        keyboardType: TextInputType.text,
        enabled: false,
        decoration: InputDecoration(
            labelText: "Last Name",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        controller: phoneNumberController,
        validator: Validator.validatePhoneNumber,
        enabled: false,
        decoration: InputDecoration(
            labelText: "Phone Number",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon:
                const Icon(Icons.mobile_friendly, color: kPrimaryColor)));
  }

  TextFormField buildIdTypeFormField() {
    return TextFormField(
        controller: idTypeController,
        enabled: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Id Type",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildDobFormField() {
    return TextFormField(
        controller: dobController,
        keyboardType: TextInputType.text,
        enabled: false,
        decoration: InputDecoration(
            labelText: "Date Of Birth",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }
}
