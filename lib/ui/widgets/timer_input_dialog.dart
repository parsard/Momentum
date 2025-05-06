import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../viewModel/time_tracker_view_model.dart';

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
      shape: const RoundedRectangleBorder(
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                  const SizedBox(height: 8),
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

                if (!timeTrackerViewModel.isPlaying) {
                  Navigator.of(context).pop();
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
