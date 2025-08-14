import 'package:flutter/material.dart';
import 'UI/dashboard/dashboardScreen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const WaterLevelApp());
}

class WaterLevelApp extends StatelessWidget {
  const WaterLevelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Level BLE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const DashboardScreen(),
    );
  }
}
