import 'package:get_it/get_it.dart';

import 'application/bloc/booking/booking_bloc.dart';
import 'data/repositories/local_booking_repository.dart';
import 'domain/repositories/booking_repository.dart';
import 'domain/services/slot_calculator.dart';

/// Global instance of GetIt for dependency injection.
final getIt = GetIt.instance;

/// Configures and registers all application dependencies.
///
/// This function should be called once during app initialization.
void setupServiceLocator() {
  // --- Data Layer ---
  getIt.registerLazySingleton<BookingRepository>(
    () => LocalBookingRepository(assetPath: 'assets/data.json'),
  );

  // --- Domain Layer ---
  getIt.registerLazySingleton<SlotCalculator>(
    () => SlotCalculator(),
  );

  // --- Application Layer ---
  getIt.registerFactory<BookingBloc>(
    () => BookingBloc(
      repository: getIt<BookingRepository>(),
      calculator: getIt<SlotCalculator>(),
    ),
  );
}