import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'util/error_reporter.dart';

void main() {
  runZonedGuarded(
    () async {
      final app = await App.create();
      runApp(app);
    },
    (error, stack) {
      ErrorReporter.report(error, stack);
    },
  );
}
