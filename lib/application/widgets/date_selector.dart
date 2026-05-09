import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<DateTime> days = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final date = days[index];
          final bool isSelected = DateUtils.isSameDay(date, selectedDate);

          return ChoiceChip(
            label: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getWeekday(date),
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                ),
                Text(
                  DateFormat('dd.MM').format(date),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) onDateSelected(date);
            },
            selectedColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.grey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
            ),
            showCheckmark: false,
          );
        },
      ),
    );
  }

  String _getWeekday(DateTime date) {
    return DateFormat('E', 'uk_UA').format(date);
  }
}
