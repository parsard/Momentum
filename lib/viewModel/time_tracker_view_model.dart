import 'dart:async';
import 'package:flutter/material.dart';
import '../../model/TimeEntry.dart'; // Your TimeEntry model.

class TimeTrackerViewModel extends ChangeNotifier {
  final TextEditingController projectController = TextEditingController(
    text: 'Project 1',
  );
  String timeDisplay = '00:00:00';
  bool isPlaying = false;

  Timer? _timer;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;

  List<TimeEntry> _timeEntries = [];
  int? _trackingIndex;

  // Getter for time entries
  List<TimeEntry> get timeEntries => List.unmodifiable(_timeEntries);

  /// Timer-related methods:
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
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
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

    _timeEntries.insert(0, newTimeEntry);
    _elapsedTime = Duration.zero;
    timeDisplay = '00:00:00';
    isPlaying = false;

    notifyListeners();
  }

  /// Time entry list management methods:
  void addEntry(TimeEntry entry) {
    _timeEntries.insert(0, entry);
    notifyListeners();
  }

  void removeEntryByKey(String key) {
    _timeEntries.removeWhere(
      (e) => (e.projectName + e.startTime.toString()) == key,
    );
    notifyListeners();
  }

  void removeEntry(int index) {
    if (_trackingIndex == index) stopTracking();
    _timeEntries.removeAt(index);
    notifyListeners();
  }

  void toggleFavorite(String key) {
    final index = _timeEntries.indexWhere(
      (e) => (e.projectName + e.startTime.toString()) == key,
    );
    if (index != -1) {
      _timeEntries[index].isFavorite = !_timeEntries[index].isFavorite;
      notifyListeners();
    }
  }

  void updateEntryName(int index, String newName) {
    _timeEntries[index].projectName = newName;
    notifyListeners();
  }

  void toggleTracking(int index) {
    if (_trackingIndex == index) {
      stopTracking();
    } else {
      startTracking(index);
    }
  }

  void startTracking(int index) {
    stopTracking();
    _trackingIndex = index;
    _timeEntries[index].isTracking = true;
    _timeEntries[index].startTime = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _timeEntries[index].duration += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stopTracking() {
    if (_trackingIndex != null) {
      _timeEntries[_trackingIndex!].isTracking = false;
      _timer?.cancel();
      _timer = null;
      _trackingIndex = null;
      notifyListeners();
    }
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
