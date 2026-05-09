import '../../domain/entities/appointment_entity.dart';
import '../mappers/time_mapper.dart';

/// DTO for parsing appointment data from JSON.
class AppointmentDto {
  final String id;
  final String date;
  final String start;
  final String end;

  AppointmentDto({
    required this.id,
    required this.date,
    required this.start,
    required this.end,
  });

  factory AppointmentDto.fromJson(Map<String, dynamic> json) {
    return AppointmentDto(
      id: json['id'] as String,
      date: json['date'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
    );
  }

  /// Maps this DTO to a Domain Entity, converting strings to DateTime/Duration.
  AppointmentEntity toEntity() {
    return AppointmentEntity(
      id: id,
      date: DateTime.parse(date),
      start: start.toDuration(),
      end: end.toDuration(),
    );
  }
}