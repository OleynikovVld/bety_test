import '../../domain/entities/service_entity.dart';

/// DTO for parsing service data from JSON.
class ServiceDto {
  final String id;
  final String name;
  final int durationMinutes;

  ServiceDto({
    required this.id,
    required this.name,
    required this.durationMinutes,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json) {
    return ServiceDto(
      id: json['id'] as String,
      name: json['name'] as String,
      durationMinutes: json['durationMinutes'] as int,
    );
  }

  /// Maps this DTO to a Domain Entity.
  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      name: name,
      durationMinutes: durationMinutes,
    );
  }
}