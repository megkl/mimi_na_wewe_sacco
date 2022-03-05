import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:mimi_na_wewe_sacco/config/routes.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/data/validators/validator.dart';
import 'package:mimi_na_wewe_sacco/view/feature/profile/add_profile.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_in/sign_In.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_in/sign_in_with_email.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_up/sign_up.dart';
import 'package:mimi_na_wewe_sacco/view/widget/widgets.dart';

import '../authentication/authentication_bloc.dart';
import '../profile/profile.dart';

class SignUpWithEmailScreen extends StatefulWidget {
  const SignUpWithEmailScreen({Key? key}) : super(key: key);

  @override
  _SignUpWithEmailScreenState createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // var position = Position(
  //     longitude: 0.0,
  //     latitude: 0.0,
  //     timestamp: null,
  //     accuracy: 0.0,
  //     altitude: 0.0,
  //     heading: 0.0,
  //     speed: 0.0,
  //     speedAccuracy: 0.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) async {
          // position = await Geolocator.getCurrentPosition(
          //     forceAndroidLocationManager: true,
          //     desiredAccuracy: LocationAccuracy.high);

          if (state is SignUpFinishedState) {
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
                        child: AddProfileScreen(
                          username: usernameController.text,
                        ))));
          }
          // on failure show a snackbar
          if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }, builder: (context, state) {
          // show loading screen while processing
          if (state is SignUpProcessingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Colors.purpleAccent,
                      Colors.amber,
                      Colors.blue,
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: getProportionalScreenHeight(50),
                    ),
                    SizedBox(
                      height: getProportionalScreenHeight(150),
                      width: getProportionalScreenWidth(150),
                      child: LottieBuilder.network(
                        "https://assets4.lottiefiles.com/private_files/lf30_mg5bq9pg.json",
                        repeat: false,
                      ),
                    ),
                    SizedBox(
                      height: getProportionalScreenHeight(10),
                    ),
                    Container(
                      width: getProportionalScreenWidth(325),
                      height: getProportionalScreenHeight(520),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getProportionalScreenHeight(30),
                            ),
                            Text(
                              "Hello",
                              style: TextStyle(
                                  fontSize: getProportionalScreenWidth(28),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: getProportionalScreenHeight(10),
                            ),
                            Text(
                              "Please Sign Up for a Mimi na wewe Account",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: getProportionalScreenHeight(15),
                              ),
                            ),
                            SizedBox(
                              height: getProportionalScreenHeight(30),
                            ),
                            Container(
                              width: getProportionalScreenWidth(260),
                              height: getProportionalScreenHeight(60),
                              child: TextFormField(
                                controller: usernameController,
                                validator: Validator.valueExists,
                                decoration: InputDecoration(
                                    suffix: Icon(
                                      Icons.person,
                                      color: Colors.purple,
                                    ),
                                    labelText: "UserName",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: getProportionalScreenHeight(12),
                            ),
                            SizedBox(
                              width: getProportionalScreenWidth(260),
                              height: getProportionalScreenHeight(60),
                              child: TextFormField(
                                controller: emailController,
                                validator: Validator.validateEmail,
                                decoration: const InputDecoration(
                                    suffix: Icon(
                                      FontAwesomeIcons.envelope,
                                      color: Colors.purple,
                                    ),
                                    labelText: "Email Address",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: getProportionalScreenHeight(12),
                            ),
                            SizedBox(
                              width: getProportionalScreenWidth(260),
                              height: getProportionalScreenHeight(50),
                              child: TextFormField(
                                controller: passwordController,
                                validator: Validator.valueExists,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    suffix: Icon(
                                      FontAwesomeIcons.eyeSlash,
                                      color: Colors.purple,
                                    ),
                                    labelText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  getProportionalScreenWidth(20),
                                  0,
                                  getProportionalScreenWidth(30),
                                  0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forgot Password",
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _validateAndSend(),
                              child: Container(
                                alignment: Alignment.center,
                                width: getProportionalScreenWidth(250),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF8A2387),
                                          Color(0xFFE94057),
                                          Color(0xFFF27121),
                                        ])),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      getProportionalScreenHeight(12)),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            getProportionalScreenWidth(20),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionalScreenHeight(17),
                            ),
                            const Text(
                              "Or Sign Up using Social Media Account",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: getProportionalScreenHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(FontAwesomeIcons.facebook,
                                        color: Colors.blue)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.redAccent,
                                    )),
                                // IconButton(
                                //     onPressed: (){},
                                //     icon: const Icon(
                                //       FontAwesomeIcons.twitter,
                                //       color: Colors.blueAccent,
                                //     )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesomeIcons.linkedinIn,
                                      color: Colors.blueAccent,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: getProportionalScreenHeight(15),
                            ),
                            InkWell(
                              onTap: () {
                                _showSignInWithEmail();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?  ",
                                    style: textStyle,
                                  ),
                                  Text(
                                    'Sign In',
                                    style: purpletextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }

  _showSignInWithEmail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(
                      userRepository:
                          RepositoryProvider.of<UserRepository>(context),
                      authenticationBloc:
                          BlocProvider.of<AuthenticationBloc>(context),
                    ),
                child: SignInWithEmailScreen())));
  }

  _validateAndSend() {
    if (_formKey.currentState!.validate()) {
      return BlocProvider.of<SignUpBloc>(context).add(SignUpPressed(
          emailAddress: emailController.text.trimRight(),
          phoneNumber: "",
          registrationType: "email_address",
          userLocation: "kenya",
          password: passwordController.text,
          socialId: "",
          isAdmin: false,
          isVerified: false,
          username: usernameController.text));
    }
  }
}
