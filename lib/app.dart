import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'util/logger.dart';

class App extends StatelessWidget {
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

  static Future<Widget> create() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    logger.i('App initialization complete.');

    return const App._();
  }
}
