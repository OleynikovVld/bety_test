/// Represents a beauty service offered by a professional.
class ServiceEntity {
  /// Unique identifier for the service.
  final String id;

  /// Display name of the service.
  final String name;

  /// Duration of the service in minutes.
  final int durationMinutes;

  const ServiceEntity({
    required this.id,
    required this.name,
    required this.durationMinutes,
  });
}