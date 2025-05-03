import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momentum/core/constants/app_colors.dart';
import 'package:momentum/core/constants/svg_path.dart';
import 'package:momentum/ui/view/widgets/custom_outlined_button.dart';
import 'package:momentum/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.babyPowder,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                'Momentum ',
                style: TextStyle(fontSize: 45, fontFamily: 'Madimi One'),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 240,
                  height: 240,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 30,
                        child: Image.asset(SvgPath.stopWatch, width: 200),
                      ),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: Image.asset(SvgPath.girlCalender, width: 170),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 100),
              const Text(
                'Log In',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 70),
                child: CustomOutlinedButton(
                  text: 'Continue with google',
                  iconPath: SvgPath.googleIcon,
                  onPressed: () {
                    // Call the login function from the view model
                    Provider.of<LoginViewModel>(
                      context,
                      listen: false,
                    ).loginWithGoogle(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
