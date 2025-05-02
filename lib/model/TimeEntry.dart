class TimeEntry {
  String projectName;
  Duration duration;

  DateTime? startTime;
  DateTime? endTime;

  String? Description;

  TimeEntry({
    required this.projectName,
    required this.duration,
    this.startTime,
    this.endTime,
    this.Description,
  });
}
