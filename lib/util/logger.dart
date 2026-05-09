import 'package:logger/logger.dart';

/// Global logger instance for the entire application.
/// Configured to show concise logs for standard info and detailed stack traces for errors.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
  ),
);
