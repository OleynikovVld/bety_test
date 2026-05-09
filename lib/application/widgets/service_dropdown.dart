import 'package:flutter/material.dart';
import '../../../domain/entities/service_entity.dart';

/// A styled dropdown widget for selecting a beauty service.
class ServiceDropdown extends StatelessWidget {
  final List<ServiceEntity> services;
  final ServiceEntity selectedService;
  final ValueChanged<ServiceEntity?> onChanged;

  const ServiceDropdown({
    super.key,
    required this.services,
    required this.selectedService,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ServiceEntity>(
      initialValue: selectedService,
      isExpanded: true, // Takes full width
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: services.map((service) {
        return DropdownMenuItem<ServiceEntity>(
          value: service,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(service.name, style: const TextStyle(fontSize: 16)),
              Text(
                '${service.durationMinutes} хв',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
