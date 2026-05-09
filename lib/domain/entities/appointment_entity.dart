/// Represents an existing booking in the calendar.
class AppointmentEntity {
  /// Unique identifier for the appointment.
  final String id;

  /// The specific date of the appointment.
  final DateTime date;

  /// Start time represented as a [Duration] from the beginning of the day.
  final Duration start;

  /// End time represented as a [Duration] from the beginning of the day.
  final Duration end;

  const AppointmentEntity({
    required this.id,
    required this.date,
    required this.start,
    required this.end,
  });
}