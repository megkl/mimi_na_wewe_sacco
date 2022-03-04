import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mimi_na_wewe_sacco/view/feature/product/product_list.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/profile.dart';

import '../../../domain/model/profile_entity.dart';
import '../../widget/widgets.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  // This is the entered code
  // It will be displayed in a Text widget
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
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Settings',
            style: const TextStyle(color: kWhiteColor),
          ),
          backgroundColor: kSecondaryColor,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.withOpacity(0.02),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileProcessingState) {
                return buildLoading();
              } else if (state is ProfileLoaded) {
                return buildProfileDetails(state.profileEntity!);
              } else if (state is ProfileErrorState) {
                return buildErrorUi(state.error);
              }
              return Container();
            },
          ),
        ));
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildProfileDetails(ProfileEntity profileEntity) {
    return ListView(
      children: <Widget>[
        Center(
          child: otherDetails(
              "", profileEntity.firstName! + ' ' + profileEntity.lastName!),
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.01),
        Text(
          profileEntity.emailAddress!,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        EditButton(
          text: "Profile Details",
          press: () {
            navigateToEditProfile(context, profileEntity);
          },
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        SizedBox(height: SizeConfiguration.screenHeight * 0.01),
        SettingsButton(
          icon: FontAwesomeIcons.moon,
          text: "Dark Mode",
          press: () {
            //_incrementCounter();
          },
          endIcon: FontAwesomeIcons.toggleOff,
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        Center(child: Text("Activity", style: headingtextStyle)),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        SettingsButton(
          icon: Icons.notifications_active,
          text: "Notifications",
          press: () {},
          endIcon: FontAwesomeIcons.arrowAltCircleRight,
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.01),
        SettingsButton(
          icon: FontAwesomeIcons.exchangeAlt,
          text: "Products",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductListScreen()));
          },
          endIcon: FontAwesomeIcons.arrowAltCircleRight,
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.01),
        SettingsButton(
          icon: FontAwesomeIcons.creditCard,
          text: "My Dreams",
          press: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const Accounts()));
          },
          endIcon: FontAwesomeIcons.arrowAltCircleRight,
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        Center(child: Text("Security", style: headingtextStyle)),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        SettingsButton(
          icon: FontAwesomeIcons.unlock,
          text: "Change Password",
          press: () {},
          endIcon: FontAwesomeIcons.arrowAltCircleRight,
        ),
        // SettingsButton(
        //   icon: FontAwesomeIcons.fingerprint,
        //   text: "Fingerprint",
        //   press: () {},
        //   endIcon: FontAwesomeIcons.arrowAltCircleRight,
        // ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.01),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        Center(child: Text("Misc", style: headingtextStyle)),
        SizedBox(height: SizeConfiguration.screenHeight * 0.02),
        SettingsButton(
          icon: Icons.book_sharp,
          text: "Terms and Conditions",
          press: () {},
          endIcon: FontAwesomeIcons.arrowAltCircleRight,
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.01),
        SettingsButton(
          icon: Icons.privacy_tip,
          text: "Privacy policy",
          press: () {},
          endIcon: FontAwesomeIcons.arrowAltCircleRight,
        ),
        SizedBox(height: SizeConfiguration.screenHeight * 0.01),
      ],
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$label", style: headingtextStyle),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: headingtextStyle,
          )
        ],
      ),
    );
  }

  void navigateToEditProfile(
      BuildContext context, ProfileEntity profileEntity) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditProfileScreen(
        profileEntity: profileEntity,
      );
    }));
  }

  // void navigateToAoutPage(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return AboutPage();
  //   }));
  // }
}
