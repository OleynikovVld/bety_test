import 'logger.dart';

/// Service responsible for handling and reporting global application exceptions.
class ErrorReporter {
  /// Reports unhandled exceptions to the console and analytics services.
  static Future<void> report(
    Object error,
    StackTrace stack, {
    bool isFatal = false,
  }) async {
    final prefix = isFatal ? 'FATAL CRASH' : 'HANDLED ERROR';
    logger.e(
      '[$prefix] Intercepted by ErrorReporter',
      error: error,
      stackTrace: stack,
    );
  }
}
