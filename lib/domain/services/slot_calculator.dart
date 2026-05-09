import '../entities/appointment_entity.dart';
import '../entities/service_entity.dart';
import '../entities/slot_entity.dart';
import '../entities/working_hours_entity.dart';

/// Domain service responsible for calculating the grid of booking slots.
class SlotCalculator {
  /// The fixed increment for the slot grid.
  static const int gridStepMinutes = 15;

  /// Calculates the full grid of slots for a specific service on a target date.
  ///
  /// Iterates through the working day using the defined [gridStepMinutes].
  /// Evaluates each potential slot and assigns a [SlotStatus] based on:
  /// 1. Working hours boundaries.
  /// 2. Scheduled breaks.
  /// 3. Existing appointments (considering required buffers).
  /// 4. Current time (for same-day bookings).
  List<SlotEntity> calculateGrid({
    required DateTime targetDate,
    required ServiceEntity selectedService,
    required WorkingHoursEntity workingHours,
    required List<AppointmentEntity> existingAppointments,
    required int bufferMinutes,
    DateTime? currentTime,
  }) {
    final List<SlotEntity> grid = [];
    final serviceDuration = Duration(minutes: selectedService.durationMinutes);
    final buffer = Duration(minutes: bufferMinutes);
    final now = currentTime ?? DateTime.now();

    // Filter appointments to only include those on the target date.
    final appointmentsForTargetDate = existingAppointments.where((appointment) => 
      appointment.date.year == targetDate.year &&
      appointment.date.month == targetDate.month &&
      appointment.date.day == targetDate.day
    ).toList();

    Duration currentPointer = workingHours.start;

    while (currentPointer + serviceDuration <= workingHours.end) {
      final slotStart = currentPointer;
      final slotEnd = currentPointer + serviceDuration;

      if (_isPast(targetDate, slotStart, now)) {
        grid.add(SlotEntity(
          startTime: slotStart,
          status: SlotStatus.past,
          unavailableReason: 'Passed',
        ));
      } 
      else if (_hasBreakOverlap(slotStart, slotEnd, workingHours.breaks)) {
        grid.add(SlotEntity(
          startTime: slotStart,
          status: SlotStatus.breakTime,
          unavailableReason: 'Lunch',
        ));
      }
      else if (_hasAppointmentOverlap(slotStart, slotEnd, appointmentsForTargetDate, buffer)) {
        grid.add(SlotEntity(
          startTime: slotStart,
          status: SlotStatus.occupied,
          unavailableReason: 'Occupied',
        ));
      }
      else {
        grid.add(SlotEntity(
          startTime: slotStart,
          status: SlotStatus.available,
        ));
      }

      currentPointer += const Duration(minutes: gridStepMinutes);
    }

    return grid;
  }

  bool _isPast(DateTime targetDate, Duration slotStart, DateTime now) {
    final DateTime slotDateTime = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      slotStart.inHours,
      slotStart.inMinutes % 60,
    );
    return slotDateTime.isBefore(now);
  }

  bool _hasBreakOverlap(Duration start, Duration end, List<BreakEntity> breaks) {
    for (final breakPeriod in breaks) {
      if (_isOverlapping(start, end, breakPeriod.start, breakPeriod.end)) {
        return true;
      }
    }
    return false;
  }

  bool _hasAppointmentOverlap(
    Duration start,
    Duration end,
    List<AppointmentEntity> appointments,
    Duration buffer,
  ) {
    for (final appointment in appointments) {
      final blockedStart = appointment.start - buffer;
      final blockedEnd = appointment.end + buffer;

      if (_isOverlapping(start, end, blockedStart, blockedEnd)) {
        return true;
      }
    }
    return false;
  }

  /// Helper to check if two time intervals intersect.
  bool _isOverlapping(Duration s1, Duration e1, Duration s2, Duration e2) {
    return s1 < e2 && s2 < e1;
  }
}