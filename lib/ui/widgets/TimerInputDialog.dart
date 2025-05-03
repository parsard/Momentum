import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:momentum/core/constants/app_colors.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';
import 'package:momentum/viewModel/time_tracker_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/time_entry.dart';
import '../view/TimeListPage.dart';

class TimerInputDialog extends StatefulWidget {
  const TimerInputDialog({super.key});

  @override
  State<TimerInputDialog> createState() => _TimerInputDialogState();
}

class _TimerInputDialogState extends State<TimerInputDialog> {
  @override
  Widget build(BuildContext context) {
    final timeTrackerViewModel = Provider.of<TimeTrackerViewModel>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 412,
        height: 130,
        color: AppColors.green_100,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: timeTrackerViewModel.projectController,
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: HexColor('#898989'),
                    ),
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  SizedBox(height: 8),

                  Text(
                    timeTrackerViewModel.timeDisplay,
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: HexColor('#121113'),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                timeTrackerViewModel.togglePlayPause();

                // If paused, navigate
                if (!timeTrackerViewModel.isPlaying) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeListPage()),
                  );
                }
              },
              child: SvgPicture.asset(
                timeTrackerViewModel.isPlaying
                    ? 'assets/buttons/pause.svg'
                    : 'assets/buttons/play.svg',
                width: 56,
                height: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
