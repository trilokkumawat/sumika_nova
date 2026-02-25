import 'package:logger/logger.dart';

/// App-wide logger. Use instead of [print] or [debugPrint].
/// Levels: [AppLogger.d] (debug), [AppLogger.i] (info), [AppLogger.w] (warning), [AppLogger.e] (error).
final class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 4,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
    level: Level.debug,
  );

  /// Debug (replaces debugPrint).
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Info.
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Warning.
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Error.
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
