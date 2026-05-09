import 'package:flutter/material.dart';
import '../../../domain/entities/slot_entity.dart';
import 'slot_card.dart';

class SlotsGrid extends StatelessWidget {
  final List<SlotEntity> slots;
  final SlotEntity? selectedSlot;
  final Function(SlotEntity) onSlotSelected;

  const SlotsGrid({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return const Center(child: Text('На цей день немає доступных слотів'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.2,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        return SlotCard(
          slot: slot,
          isSelected: selectedSlot == slot,
          onTap: () => onSlotSelected(slot),
        );
      },
    );
  }
}
