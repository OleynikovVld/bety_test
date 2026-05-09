import '../entities/appointment_entity.dart';
import '../entities/service_entity.dart';
import '../entities/working_hours_entity.dart';

/// Contract for the data layer to provide booking-related information.
abstract interface class BookingRepository {
  /// Retrieves the master's working hours, including scheduled breaks.
  Future<WorkingHoursEntity> getWorkingHours();

  /// Retrieves the mandatory buffer time (in minutes) required between appointments.
  Future<int> getBufferMinutes();

  /// Retrieves the list of all available beauty services.
  Future<List<ServiceEntity>> getServices();

  /// Retrieves the list of existing appointments.
  Future<List<AppointmentEntity>> getAppointments();
}