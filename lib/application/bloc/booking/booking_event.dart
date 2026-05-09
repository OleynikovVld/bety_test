import 'package:equatable/equatable.dart';

import '../../../domain/entities/service_entity.dart';
import '../../../domain/entities/slot_entity.dart';

/// Base class for all booking events.
abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered to load the initial booking data and populate the screen.
class LoadBookingDataEvent extends BookingEvent {}

/// Event triggered when the user selects a different beauty service.
class SelectServiceEvent extends BookingEvent {
  final ServiceEntity service;

  const SelectServiceEvent(this.service);

  @override
  List<Object?> get props => [service];
}

/// Event triggered when the user selects a different date in the calendar.
class SelectDateEvent extends BookingEvent {
  final DateTime date;

  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

/// Event triggered when the user selects a different time slot in the calendar.
class SelectSlotEvent extends BookingEvent {
  final SlotEntity slot;

  const SelectSlotEvent(this.slot);

  @override
  List<Object?> get props => [slot];
}