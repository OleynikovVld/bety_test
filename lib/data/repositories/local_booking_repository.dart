import 'dart:convert';
import 'package:flutter/services.dart';

import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/working_hours_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../models/appointment_dto.dart';
import '../models/service_dto.dart';
import '../models/working_hours_dto.dart';

/// Implementation of [BookingRepository] that loads data from a local JSON asset.
class LocalBookingRepository implements BookingRepository {
  final String assetPath;

  WorkingHoursEntity? _workingHours;
  int? _bufferMinutes;
  List<ServiceEntity>? _services;
  List<AppointmentEntity>? _appointments;

  bool _isLoaded = false;

  LocalBookingRepository({this.assetPath = 'assets/data.json'});

  /// Loads and parses the JSON file. 
  /// Must be called once before accessing other methods to cache data.
  Future<void> init() async {
    if (_isLoaded) return;

    final jsonString = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    final workingHoursDto = WorkingHoursDto.fromJson(jsonMap['workingHours']);
    _workingHours = workingHoursDto.toEntity();

    _bufferMinutes = jsonMap['bufferMinutes'] as int;

    _services = (jsonMap['services'] as List<dynamic>)
        .map((e) => ServiceDto.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();

    _appointments = (jsonMap['appointments'] as List<dynamic>)
        .map((e) => AppointmentDto.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();

    _isLoaded = true;
  }

  @override
  Future<WorkingHoursEntity> getWorkingHours() async {
    await init();
    return _workingHours!;
  }

  @override
  Future<int> getBufferMinutes() async {
    await init();
    return _bufferMinutes!;
  }

  @override
  Future<List<ServiceEntity>> getServices() async {
    await init();
    return _services!;
  }

  @override
  Future<List<AppointmentEntity>> getAppointments() async {
    await init();
    return _appointments!;
  }
}