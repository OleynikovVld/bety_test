import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/booking/booking_bloc.dart';
import '../../../application/bloc/booking/booking_event.dart';
import '../../../application/bloc/booking/booking_state.dart';
import '../../../service_locator.dart';
import '../widgets/date_selector.dart';
import '../widgets/service_dropdown.dart';
import '../widgets/slots_grid.dart';

/// The main entry point for the Booking (New Appointment) screen.
///
/// This widget is responsible for initializing the [BookingBloc] and
/// triggering the initial data load.
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingBloc>(
      create: (context) => getIt<BookingBloc>()..add(LoadBookingDataEvent()),
      child: const BookingView(),
    );
  }
}

/// The internal view of the [BookingPage] that reacts to the [BookingBloc] states.
class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новий запис'), centerTitle: true),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<BookingBloc>().add(LoadBookingDataEvent()),
                    child: const Text('Спробувати ще раз'),
                  ),
                ],
              ),
            );
          }

          if (state is BookingLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Послуга',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildServiceSection(state, context),
                  const SizedBox(height: 24),
                  const Text(
                    'Дата та час',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildSlotsSection(state, context),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildServiceSection(BookingLoaded state, BuildContext context) {
    return ServiceDropdown(
      services: state.services,
      selectedService: state.selectedService,
      onChanged: (newService) {
        if (newService != null) {
          context.read<BookingBloc>().add(SelectServiceEvent(newService));
        }
      },
    );
  }

  Widget _buildSlotsSection(BookingLoaded state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateSelector(
          selectedDate: state.selectedDate,
          onDateSelected: (newDate) {
            context.read<BookingBloc>().add(SelectDateEvent(newDate));
          },
        ),

        const SizedBox(height: 24),
        SlotsGrid(
          slots: state.slots,
          selectedSlot: state.selectedSlot,
          onSlotSelected: (slot) {
            context.read<BookingBloc>().add(SelectSlotEvent(slot));
          },
        ),
      ],
    );
  }
}
