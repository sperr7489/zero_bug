import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'color_schemes.g.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'configuration/audio/audio_service_manager.dart';
import 'configuration/db/shared_preference.dart';
import 'configuration/local_notification.dart';
import 'feature/splash/splash_screen.dart';

Future<void> main() async {
  await AudioServiceManager.init();
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  SharedPreferences prefs = await SharedPreferences.getInstance();

  SharedPreferencesManager.instance.setPreferences(prefs);

  LocalNotification.initialize();

  LocalNotification.requestPermission();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZeroBug',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white70,
          elevation: 3,
          shadowColor: Colors.black26,
        ),
        fontFamily: 'Stylish',
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const SplashScreen(),
    );
  }
}
