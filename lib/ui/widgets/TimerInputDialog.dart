import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:momentum/core/constants/app_colors.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';

import '../../model/TimeEntry.dart';
import '../view/TimeListPage.dart';

class TimerInputDialog extends StatefulWidget {
  const TimerInputDialog({super.key});

  @override
  State<TimerInputDialog> createState() => _TimerInputDialogState();
}

class _TimerInputDialogState extends State<TimerInputDialog> {
  TextEditingController _projectController = TextEditingController(
    text: 'Project 1',
  );
  String _timeDisplay = '00:00:00';

  bool isPlaying = false;

  Timer? _timer;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;

  List<TimeEntry> _timeEntries = [];

  @override
  void dispose() {
    _projectController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _startTime = DateTime.now();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        final now = DateTime.now();
        _elapsedTime = now.difference(_startTime!);
        _timeDisplay = _formatDuration(_elapsedTime);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;

    final newTimeEntry = TimeEntry(
      projectName: _projectController.text,
      duration: _elapsedTime,
      startTime: _startTime,
      endTime: DateTime.now(),
    );

    _timeEntries.add(newTimeEntry);

    print('Time entry saved: $newTimeEntry');

    _elapsedTime = Duration.zero;
    _timeDisplay = '00:00:00';
    Navigator.of(context).pop();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TimeListPage()),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _projectController,
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
                    _timeDisplay,
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
              onTap: _togglePlayPause,
              child: SvgPicture.asset(
                isPlaying
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
