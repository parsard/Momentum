class TimeEntry {
  String projectName;
  Duration duration;

  DateTime? startTime;
  DateTime? endTime;

  String? Description;

  bool isTracking;
  bool isFavorite;

  TimeEntry({
    required this.projectName,
    required this.duration,

    this.startTime,
    this.endTime,
    this.Description,
    this.isTracking = false,
    this.isFavorite = false,
  });
}
