import 'package:flutter/material.dart';
import 'package:mimi_na_wewe_sacco/view/widget/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfiguration().init(context);
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/logo.png",
              height: SizeConfiguration.screenHeight * 0.5,
              width: SizeConfiguration.screenWidth,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: getProportionalScreenHeight(220)),
                Text("Mimi na Wewe Sacco", style: subHeadingtextStyle),
                Text("Simple  .  Easy  .  Empowering",
                    style: subHeadingtextStyle),
              ],
            ),
          ],
        ));
  }
}
