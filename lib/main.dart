import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/app.dart';
import 'package:test_payment_app/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
