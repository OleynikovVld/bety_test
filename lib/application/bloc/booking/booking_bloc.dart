import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/service_entity.dart';
import '../../../domain/repositories/booking_repository.dart';
import '../../../domain/services/slot_calculator.dart';
import '../../../util/error_reporter.dart';
import '../../../util/logger.dart';
import 'booking_event.dart';
import 'booking_state.dart';

/// Business Logic Component managing the state of the booking screen.
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository _repository;
  final SlotCalculator _calculator;

  BookingBloc({
    required BookingRepository repository,
    required SlotCalculator calculator,
  }) : _repository = repository,
       _calculator = calculator,
       super(BookingInitial()) {
    on<LoadBookingDataEvent>(_onLoadBookingData);
    on<SelectServiceEvent>(_onSelectService);
    on<SelectDateEvent>(_onSelectDate);
    on<SelectSlotEvent>(_onSelectSlot);
  }

  Future<void> _onLoadBookingData(
    LoadBookingDataEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final services = await _repository.getServices();

      if (services.isEmpty) {
        emit(const BookingError('No services available.'));
        return;
      }

      final defaultDate = DateTime.now();
      final defaultService = services.first;

      await _calculateAndEmitSlots(
        emit: emit,
        services: services,
        selectedService: defaultService,
        selectedDate: defaultDate,
      );
    } catch (e, stack) {
      ErrorReporter.report(e, stack);
      emit(BookingError('Failed to initialize booking screen.'));
    }
  }

  Future<void> _onSelectService(
    SelectServiceEvent event,
    Emitter<BookingState> emit,
  ) async {
    if (state is BookingLoaded) {
      final currentState = state as BookingLoaded;

      await _calculateAndEmitSlots(
        emit: emit,
        services: currentState.services,
        selectedService: event.service,
        selectedDate: currentState.selectedDate,
      );
    }
  }

  Future<void> _onSelectDate(
    SelectDateEvent event,
    Emitter<BookingState> emit,
  ) async {
    if (state is BookingLoaded) {
      final currentState = state as BookingLoaded;

      await _calculateAndEmitSlots(
        emit: emit,
        services: currentState.services,
        selectedService: currentState.selectedService,
        selectedDate: event.date,
      );
    }
  }

  void _onSelectSlot(SelectSlotEvent event, Emitter<BookingState> emit) {
    if (state is BookingLoaded) {
      final currentState = state as BookingLoaded;
      logger.i('''
          [BOOKING SELECTION]
          Service:    ${currentState.selectedService.name}
          Date:       ${currentState.selectedDate.day}.${currentState.selectedDate.month}.${currentState.selectedDate.year}
          Start Time: ${event.slot.startTime}
      ''');
      emit(currentState.copyWith(selectedSlot: event.slot));
    }
  }

  Future<void> _calculateAndEmitSlots({
    required Emitter<BookingState> emit,
    required List<ServiceEntity> services,
    required ServiceEntity selectedService,
    required DateTime selectedDate,
  }) async {
    try {
      final workingHours = await _repository.getWorkingHours();
      final appointments = await _repository.getAppointments();
      final bufferMinutes = await _repository.getBufferMinutes();

      final slots = _calculator.calculateGrid(
        targetDate: selectedDate,
        selectedService: selectedService,
        workingHours: workingHours,
        existingAppointments: appointments,
        bufferMinutes: bufferMinutes,
      );

      emit(
        BookingLoaded(
          services: services,
          selectedService: selectedService,
          selectedDate: selectedDate,
          slots: slots,
        ),
      );
    } catch (e, stack) {
      ErrorReporter.report(e, stack);
      emit(BookingError('Failed to calculate slots: $e'));
    }
  }
}
