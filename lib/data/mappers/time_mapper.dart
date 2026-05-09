import 'package:intl/intl.dart';

/// An extension on [String] to provide time-parsing utilities.
extension StringTimeParsing on String {
  /// Parses a time string in "HH:mm" format into a [Duration].
  ///
  /// The resulting [Duration] represents the time elapsed since midnight.
  /// Useful for mapping DTO time representations into Domain entities.
  ///
  /// Throws a [FormatException] if the string cannot be parsed.
  Duration toDuration() {
    try {
      final DateTime parsedDate = DateFormat('HH:mm').parse(this);
      
      return Duration(
        hours: parsedDate.hour,
        minutes: parsedDate.minute,
      );
    } catch (e) {
      throw FormatException('Error parsing time "$this": expected "HH:mm" format.');
    }
  }
}