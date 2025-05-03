import 'dart:async';
import 'package:flutter/material.dart';
import '../../model/TimeEntry.dart';

class TimeTrackerViewModel extends ChangeNotifier {
  final TextEditingController projectController = TextEditingController(
    text: 'Project 1',
  );
  String timeDisplay = '00:00:00';
  bool isPlaying = false;

  Timer? _timer;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;
  final List<TimeEntry> _timeEntries = [];

  List<TimeEntry> get timeEntries => List.unmodifiable(_timeEntries);

  void togglePlayPause() {
    isPlaying = !isPlaying;
    if (isPlaying) {
      _startTimer();
    } else {
      _stopTimer();
    }
    notifyListeners();
  }

  void _startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      _elapsedTime = now.difference(_startTime!);
      timeDisplay = _formatDuration(_elapsedTime);
      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;

    final newTimeEntry = TimeEntry(
      projectName: projectController.text,
      duration: _elapsedTime,
      startTime: _startTime,
      endTime: DateTime.now(),
    );

    _timeEntries.add(newTimeEntry);

    // Reset
    _elapsedTime = Duration.zero;
    timeDisplay = '00:00:00';
    isPlaying = false;
    notifyListeners();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    projectController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
