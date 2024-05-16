import 'package:flutter/material.dart';
import 'package:app/app.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Removes "#" from URL, for more check out link below:
  // https://docs.flutter.dev/development/ui/navigation/url-strategies
  usePathUrlStrategy();
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
