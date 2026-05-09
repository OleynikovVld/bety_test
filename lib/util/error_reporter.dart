import 'logger.dart';

/// Service responsible for handling and reporting global application exceptions.
class ErrorReporter {
  /// Reports unhandled exceptions to the console and analytics services.
  static Future<void> report(Object error, StackTrace stack) async {
    logger.e(
      'Unhandled exception intercepted',
      error: error,
      stackTrace: stack,
    );
  }
}
