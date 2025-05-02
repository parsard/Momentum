import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momentum/core/constants/app_colors.dart';
import 'package:momentum/ui/widgets/AddButton.dart';
import 'package:momentum/ui/widgets/footer.dart';

class TimeTrackerPage extends StatelessWidget {
  const TimeTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green_50,
      body: Stack(
        children: [
          Positioned(
            top: 250,
            left: 90,
            child: Image.asset('assets/trackerPage/Girl1.png'),
          ),

          Positioned(
            bottom: 200, // Adjust as needed for vertical positioning
            right: 30, // Adjust as needed for horizontal positioning
            child: Container(
              width: 246,
              height: 65,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.myOrange, // Adjust color as needed
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'click here to start your first time tracking.',
                  style: TextStyle(
                    color: Colors.black, // Adjust text color as needed
                    fontSize: 15.0,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          AddButton(),

          AppFooter(),
        ],
      ),
    );
  }
}
