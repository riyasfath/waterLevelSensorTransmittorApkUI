import 'package:flutter/material.dart';
import 'package:waterlevelcopy/sccreeens/HomeScreen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const DashboardScreen(), // Directly open HomeScreen
    );
  }
}
