import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_na_wewe_sacco/config/routes.dart';
import 'package:mimi_na_wewe_sacco/data/validators/validator.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/profile.dart';
import 'package:mimi_na_wewe_sacco/view/widget/widgets.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({Key? key, this.emailAddress, this.phoneNumber})
      : super(key: key);
  final String? emailAddress;
  final String? phoneNumber;
  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  //final TextEditingController countryController = TextEditingController();

  String? countrySelectedValue = 'Kenya';

  final _formKey = GlobalKey<FormState>();

  late double sizeBetween;
  late ProfileBloc profileBloc;
  late ProfileEntity profileEntity;

  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(ShowProfilePressed());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // on success delete navigator stack and push to home
          if (state is ProfileFinishedState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              MimiNaWeweSacco.home,
              (Route<dynamic> route) => false,
            );
          }
          // on failure show a snackbar
          if (state is ProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          // show loading screen while processing
          if (state is ProfileProcessingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionalScreenWidth(20)),
                child: ListView(
                  children: [
                    // Image.asset(
                    //   "assets/icons/reg_icon.png",
                    //   height: SizeConfiguration.screenHeight * 0.15,
                    //   width: SizeConfiguration.screenWidth * 0.2,
                    // ),
                    SizedBox(
                        height: SizeConfiguration.screenHeight * 0.04), // 4%
                    Text("Create Mimi na Wewe Profile",
                        style: headingtextStyle, textAlign: TextAlign.center),
                    SizedBox(
                        height: SizeConfiguration.screenHeight * 0.02), // 4%
                    Text(
                      "Enter your details to create profile",
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                    Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfiguration.screenWidth * 0.8,
                              child: buildfirstNameFormField()),
                          SizedBox(height: getProportionalScreenHeight(20)),
                          SizedBox(
                              width: SizeConfiguration.screenWidth * 0.8,
                              child: buildmiddleNameFormField()),
                          SizedBox(height: getProportionalScreenHeight(20)),
                          Container(
                              width: SizeConfiguration.screenWidth * 0.8,
                              child: buildLastNameFormField()),
                          SizedBox(height: getProportionalScreenHeight(20)),
                          Container(
                              width: SizeConfiguration.screenWidth * 0.8,
                              child: buildEmailFormField(
                                  state.profileEntity!.emailAddress)),
                          SizedBox(height: getProportionalScreenHeight(20)),
                          Container(
                              width: SizeConfiguration.screenWidth * 0.8,
                              child: buildPhoneNumberFormField(
                                  state.profileEntity!.phoneNumber!)),
                          SizedBox(height: getProportionalScreenHeight(20)),
                          Container(
                              width: SizeConfiguration.screenWidth * 0.8,
                              child: buildIdNumberFormField()),
                          SizedBox(height: getProportionalScreenHeight(30)),
                          OverallButton(
                              text: 'Create Profile', press: _validateAndSend),
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
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  TextFormField buildEmailFormField(String? emailAddress) {
    if (emailAddress!.isNotEmpty) {
      emailController = TextEditingController(text: emailAddress);
      return TextFormField(
          controller: emailController,
          enabled: false,
          decoration: InputDecoration(
              labelText: "Email Address",
              fillColor: Colors.grey,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(getProportionalScreenHeight(25)),
                borderSide: BorderSide(),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: const Icon(Icons.email, color: kPrimaryColor)));
    } else {
      return TextFormField(
          controller: emailController,
          enabled: true,
          validator: Validator.validateEmail,
          decoration: InputDecoration(
              labelText: "Email Address",
              fillColor: Colors.grey,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(getProportionalScreenHeight(25)),
                borderSide: BorderSide(),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: const Icon(Icons.email, color: kPrimaryColor)));
    }
  }

  TextFormField buildfirstNameFormField() {
    return TextFormField(
        controller: firstNameController,
        validator: Validator.valueExists,
        keyboardType: TextInputType.text,
        enabled: true,
        decoration: InputDecoration(
            labelText: "First Name",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildmiddleNameFormField() {
    return TextFormField(
        controller: middleNameController,
        validator: Validator.valueExists,
        enabled: true,
        decoration: InputDecoration(
            labelText: "Middle Name",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildIdNumberFormField() {
    return TextFormField(
        controller: idNumberController,
        validator: Validator.valueExists,
        keyboardType: TextInputType.text,
        enabled: true,
        decoration: InputDecoration(
            labelText: "Id Number",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
        controller: lastNameController,
        validator: Validator.valueExists,
        keyboardType: TextInputType.text,
        enabled: true,
        decoration: InputDecoration(
            labelText: "Last Name",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  TextFormField buildPhoneNumberFormField(String? phoneNumber) {
    if (phoneNumber!.isNotEmpty) {
      phoneController = TextEditingController(text: phoneNumber);
      return TextFormField(
          controller: phoneController,
          enabled: false,
          decoration: InputDecoration(
              labelText: "Phone Number",
              fillColor: Colors.grey,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(getProportionalScreenHeight(25)),
                borderSide: BorderSide(),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon:
                  const Icon(Icons.mobile_friendly, color: kPrimaryColor)));
    } else {
      return TextFormField(
          controller: phoneController,
          validator: Validator.validatePhoneNumber,
          enabled: true,
          decoration: InputDecoration(
              labelText: "Phone Number",
              fillColor: Colors.grey,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(getProportionalScreenHeight(25)),
                borderSide: BorderSide(),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon:
                  const Icon(Icons.mobile_friendly, color: kPrimaryColor)));
    }
  }

  void _validateAndSend() {
    if (_formKey.currentState!.validate()) {
      return BlocProvider.of<ProfileBloc>(context).add(ProfilePressed(
          email: emailController.text,
          phoneNumber: phoneController.text,
          firstName: firstNameController.text,
          middleName: middleNameController.text,
          lastName: lastNameController.text,
          idNumber: idNumberController.text,
          isAdmin: false,
          country: countrySelectedValue));
    }
  }
}
