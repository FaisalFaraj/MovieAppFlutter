import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  // setupLogger();

  var app = await initializeApp();

  runApp(
    Phoenix(
      child: app,
    ),
  );
}
