import 'dart:async';
import 'package:flutter/material.dart';
import 'package:momentum/viewModel/time_tracker_view_model.dart';
import '../../model/TimeEntry.dart';

class TimeListViewModel extends ChangeNotifier {
  final TimeTrackerViewModel tracker;
  Timer? _timer;
  int? _trackingIndex;

  TimeListViewModel(this.tracker);

  List<TimeEntry> get entries => tracker.timeEntries;

  void removeEntryByKey(String key) {
    tracker.timeEntries.removeWhere(
      (e) => (e.projectName + e.startTime.toString()) == key,
    );
    notifyListeners();
  }

  void addEntry(TimeEntry entry) {
    tracker.timeEntries.insert(0, entry);
    tracker.notifyListeners();
    notifyListeners();
  }

  void removeEntry(int index) {
    if (_trackingIndex == index) stopTracking();
    tracker.timeEntries.removeAt(index);
    tracker.notifyListeners();
    notifyListeners();
  }

  void toggleFavorite(String key) {
    final index = entries.indexWhere(
      (e) => (e.projectName + e.startTime.toString()) == key,
    );
    if (index != -1) {
      entries[index].isFavorite = !entries[index].isFavorite;
      tracker.notifyListeners();
      notifyListeners();
    }
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
    entries[index].isTracking = true;
    entries[index].startTime = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      entries[index].duration += const Duration(seconds: 1);
      tracker.notifyListeners();
      notifyListeners();
    });
    tracker.notifyListeners();
    notifyListeners();
  }

  void stopTracking() {
    if (_trackingIndex != null) {
      entries[_trackingIndex!].isTracking = false;
      _timer?.cancel();
      _timer = null;
      _trackingIndex = null;
      tracker.notifyListeners();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
