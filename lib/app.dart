import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: const Scaffold(body: Center(child: Text('Test'))),
    );
  }

  /// Asynchronous factory method to initialize the application.
  ///
  /// Returns a fully initialized [App] widget ready to be passed to [runApp].
  static Future<Widget> create() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    logger.i('App initialization complete.');

    return const App._();
  }
}
