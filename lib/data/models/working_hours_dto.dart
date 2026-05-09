import '../../domain/entities/working_hours_entity.dart';
import '../mappers/time_mapper.dart';

/// DTO for parsing break intervals from JSON.
class BreakDto {
  final String start;
  final String end;

  BreakDto({
    required this.start,
    required this.end,
  });

  factory BreakDto.fromJson(Map<String, dynamic> json) {
    return BreakDto(
      start: json['start'] as String,
      end: json['end'] as String,
    );
  }

  BreakEntity toEntity() {
    return BreakEntity(
      start: start.toDuration(),
      end: end.toDuration(),
    );
  }
}

/// DTO for parsing working hours from JSON.
class WorkingHoursDto {
  final String start;
  final String end;
  final List<BreakDto> breaks;

  WorkingHoursDto({
    required this.start,
    required this.end,
    required this.breaks,
  });

  factory WorkingHoursDto.fromJson(Map<String, dynamic> json) {
    return WorkingHoursDto(
      start: json['start'] as String,
      end: json['end'] as String,
      breaks: (json['breaks'] as List<dynamic>)
          .map((e) => BreakDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Maps this DTO to a Domain Entity, converting string times to Durations.
  WorkingHoursEntity toEntity() {
    return WorkingHoursEntity(
      start: start.toDuration(),
      end: end.toDuration(),
      breaks: breaks.map((b) => b.toEntity()).toList(),
    );
  }
}