/// Represents a time interval during which the professional is unavailable.
class BreakEntity {
  /// Start of the break as a [Duration] from the beginning of the day.
  final Duration start;

  /// End of the break as a [Duration] from the beginning of the day.
  final Duration end;

  const BreakEntity({
    required this.start,
    required this.end,
  });
}

/// Represents the master's working schedule for a day.
class WorkingHoursEntity {
  /// Start of the working day as a [Duration] from the beginning of the day.
  final Duration start;

  /// End of the working day as a [Duration] from the beginning of the day.
  final Duration end;

  /// A list of scheduled breaks during the working day.
  final List<BreakEntity> breaks;

  const WorkingHoursEntity({
    required this.start,
    required this.end,
    required this.breaks,
  });
}