/// Represents the availability status of a time slot.
enum SlotStatus {
  available,
  past,
  breakTime,
  occupied,
}

/// Represents a specific time slot in the grid with its availability details.
class SlotEntity {
  /// The start time of the slot from the beginning of the day.
  final Duration startTime;

  /// The current availability status.
  final SlotStatus status;

  /// Reason why the slot is unavailable.
  final String? unavailableReason;

  const SlotEntity({
    required this.startTime,
    required this.status,
    this.unavailableReason,
  });
}