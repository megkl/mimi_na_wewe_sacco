import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mimi_na_wewe_sacco/config/routes.dart';
import 'package:mimi_na_wewe_sacco/view/feature/home/homepage.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_in/sign_In.dart';
import 'package:mimi_na_wewe_sacco/view/feature/sign_up/sign_up_tab.dart';
import 'package:mimi_na_wewe_sacco/view/widget/widgets.dart';

import '../../../data/repository/user/user_repository.dart';
import '../authentication/authentication_bloc.dart';
import '../sign_up/sign_up.dart';

class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({Key? key}) : super(key: key);

  @override
  _SignInWithEmailScreenState createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends State<SignInWithEmailScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
          // on success delete navigator stack and push to home
          if (state is SignInFinishedState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageScreen(
                          username: usernameController.text,
                        )));
          }
          // on failure show a snackbar
          if (state is SignInErrorState) {
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
          if (state is SignInProcessingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
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
                    height: getProportionalScreenHeight(200),
                    width: getProportionalScreenWidth(200),
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
                            child: TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
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
                            child: TextField(
                              controller: passwordController,
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
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getProportionalScreenWidth(20),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionalScreenHeight(17),
                          ),
                          const Text(
                            "Or Login using Social Media Account",
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
                              _showSignUpWithEmail();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Do not have an account?  ",
                                  style: textStyle,
                                ),
                                Text(
                                  'Sign Up',
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
          );
        }));
  }

  _showSignUpWithEmail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider<SignUpBloc>(
                create: (context) => SignUpBloc(
                      userRepository:
                          RepositoryProvider.of<UserRepository>(context),
                      authenticationBloc:
                          BlocProvider.of<AuthenticationBloc>(context),
                    ),
                child: SignUpTab())));
  }

  _validateAndSend() {
    if (_formKey.currentState!.validate()) {
      return BlocProvider.of<SignInBloc>(context).add(SignInPressed(
          password: passwordController.text,
          username: usernameController.text));
    }
  }
}
