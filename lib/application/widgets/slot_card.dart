import 'package:flutter/material.dart';
import '../../../domain/entities/slot_entity.dart';

/// A single time slot card that changes its appearance based on [SlotStatus].
class SlotCard extends StatelessWidget {
  final SlotEntity slot;
  final bool isSelected;
  final VoidCallback? onTap;

  const SlotCard({
    super.key,
    required this.slot,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = slot.status == SlotStatus.available;

    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (!isAvailable) {
      backgroundColor = Colors.grey.shade200;
      textColor = Colors.grey.shade500;
      borderColor = Colors.transparent;
    } else if (isSelected) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      textColor = Colors.white;
      borderColor = Theme.of(context).colorScheme.primary;
    } else {
      backgroundColor = Colors.white;
      textColor = Theme.of(context).colorScheme.primary;
      borderColor = Theme.of(context).colorScheme.primary;
    }

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          _formatDuration(slot.startTime),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
