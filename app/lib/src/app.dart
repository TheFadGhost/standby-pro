import 'package:flutter/material.dart';
import 'domain/standby_models.dart';
import 'features/standby/standby_screen.dart';

class StandbyProApp extends StatelessWidget {
  const StandbyProApp({super.key, this.initialSettings});

  final StandbySettings? initialSettings;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Standby Pro',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFF7DD3FC),
          surface: const Color(0xFF07070A),
        ),
        fontFamily: 'Roboto',
      ),
      home: StandbyScreen(initialSettings: initialSettings),
    );
  }
}
