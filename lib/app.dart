import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'application/pages/booking_page.dart';
import 'service_locator.dart';
import 'util/logger.dart';

/// The root widget of the application.
class App extends StatelessWidget {
  /// Private constructor to prevent direct instantiation.
  ///
  /// The application must be initialized using the [create] factory method
  /// to ensure all asynchronous dependencies are resolved beforehand.
  const App._();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bety App',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const BookingPage(),
    );
  }

  /// Asynchronous factory method to initialize the application.
  ///
  /// Returns a fully initialized [App] widget ready to be passed to [runApp].
  static Future<Widget> create() async {
    // Ensure the Flutter framework is ready to interact with platform channels.
    WidgetsFlutterBinding.ensureInitialized();

    await initializeDateFormatting('uk_UA', null);

    // Lock the device orientation to portrait mode to maintain a consistent layout.
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Initialize Dependency Injection
    setupServiceLocator();

    logger.i('App initialization complete.');

    return const App._();
  }
}
