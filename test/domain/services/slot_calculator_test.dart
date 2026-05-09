import 'package:bety_test/domain/entities/service_entity.dart';
import 'package:bety_test/domain/entities/slot_entity.dart';
import 'package:bety_test/domain/entities/working_hours_entity.dart';
import 'package:bety_test/domain/services/slot_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SlotCalculator calculator;

  setUp(() {
    calculator = SlotCalculator();
  });

  final workingHours = WorkingHoursEntity(
    start: const Duration(hours: 10),
    end: const Duration(hours: 20),
    breaks: [
      BreakEntity(
        start: const Duration(hours: 14),
        end: const Duration(hours: 15),
      )
    ],
  );

  final testDate = DateTime(2026, 4, 28);

  test('slots before current time are marked as past', () {
    final service = ServiceEntity(id: 's3', name: 'Брови', durationMinutes: 30);
    
    final mockCurrentTime = DateTime(2026, 4, 28, 13, 47);

    final grid = calculator.calculateGrid(
      targetDate: testDate,
      selectedService: service,
      workingHours: workingHours,
      existingAppointments: [],
      bufferMinutes: 15,
      currentTime: mockCurrentTime,
    );

    final slot10_00 = grid.firstWhere((s) => s.startTime == const Duration(hours: 10));
    expect(slot10_00.status, SlotStatus.past);

    final slot13_30 = grid.firstWhere((s) => s.startTime == const Duration(hours: 13, minutes: 30));
    expect(slot13_30.status, SlotStatus.past);

    final slot13_45 = grid.firstWhere((s) => s.startTime == const Duration(hours: 13, minutes: 45));
    expect(slot13_45.status, SlotStatus.past);
  });

  test('slots overlapping with break are marked as breakTime', () {
    final service = ServiceEntity(id: 's3', name: 'Брови', durationMinutes: 30);
    final mockCurrentTime = DateTime(2026, 4, 28, 8, 0);

    final grid = calculator.calculateGrid(
      targetDate: testDate,
      selectedService: service,
      workingHours: workingHours,
      existingAppointments: [],
      bufferMinutes: 15,
      currentTime: mockCurrentTime,
    );

    final slot13_45 = grid.firstWhere((s) => s.startTime == const Duration(hours: 13, minutes: 45));
    expect(slot13_45.status, SlotStatus.breakTime);

    final slot14_00 = grid.firstWhere((s) => s.startTime == const Duration(hours: 14));
    expect(slot14_00.status, SlotStatus.breakTime);
  });
}