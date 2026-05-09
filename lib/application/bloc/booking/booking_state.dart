import 'package:equatable/equatable.dart';

import '../../../domain/entities/service_entity.dart';
import '../../../domain/entities/slot_entity.dart';

/// Base class for all booking states.
abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data is loaded.
class BookingInitial extends BookingState {}

/// State representing an active loading process.
class BookingLoading extends BookingState {}

/// State representing successfully loaded and calculated booking data.
class BookingLoaded extends BookingState {
  /// List of all available beauty services.
  final List<ServiceEntity> services;

  /// The currently selected service.
  final ServiceEntity selectedService;

  /// The currently selected date for the appointment.
  final DateTime selectedDate;

  /// The calculated grid of time slots for the selected date and service.
  final List<SlotEntity> slots;

  final SlotEntity? selectedSlot;

  const BookingLoaded({
    required this.services,
    required this.selectedService,
    required this.selectedDate,
    required this.slots,
    this.selectedSlot,
  });

  /// Creates a copy of this state with the given fields replaced with the new values.
  BookingLoaded copyWith({
    List<ServiceEntity>? services,
    ServiceEntity? selectedService,
    DateTime? selectedDate,
    List<SlotEntity>? slots,
    SlotEntity? selectedSlot,
  }) {
    return BookingLoaded(
      services: services ?? this.services,
      selectedService: selectedService ?? this.selectedService,
      selectedDate: selectedDate ?? this.selectedDate,
      slots: slots ?? this.slots,
      selectedSlot: selectedSlot ?? this.selectedSlot,
    );
  }

  @override
  List<Object?> get props => [
    services,
    selectedService,
    selectedDate,
    slots,
    selectedSlot,
  ];
}

/// State representing an error that occurred during data processing.
class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}
