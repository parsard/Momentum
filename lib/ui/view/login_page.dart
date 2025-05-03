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
              const SizedBox(height: 40),
              SvgPicture.asset(SvgPath.googleIcon, width: 200, height: 200),
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
                    ).loginWithGoogle();
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
