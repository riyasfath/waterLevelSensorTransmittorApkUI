import 'package:flutter/material.dart';
import 'package:waterlevelcopy/UI/dashboard/widgets/battery_field.dart';
import 'package:waterlevelcopy/UI/dashboard/widgets/key_values_card.dart';

// Widgets
import 'widgets/header_things.dart';
import 'widgets/device_tabs.dart';
import 'widgets/tank_card.dart';
import 'widgets/labeled_info_row.dart';
import 'widgets/water_position_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedDevice = 0;
  final int percent = 75;   // live value for water measure (0..100)
  final int battery = 65;   // live value for battery (0..100)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // pure white dashboard
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          headerThings(
            date: "12/08/2025",
            time: "4:39pm",
            onSettings: () {},
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Device tabs (unchanged)
                  DeviceTabs(
                    index: selectedDevice,
                    onChanged: (i) => setState(() => selectedDevice = i),
                  ),
                  const SizedBox(height: 12),

                  // Water tank art
                  TankCard(percent: percent),

                  // Last update (date left, time right)
                  const LabeledInfoRow(
                    title: "Last update",
                    left: "12/08/2025",
                    right: "6:05 AM",
                  ),

                  // Battery (icon left, % right)
                  BatteryProgressCard(
                    level: battery,
                    surfaceColor: Colors.transparent,
                  ),

                  // Water position: DISPLAY ONLY, nearest chip highlighted
                  WaterPositionCard(level: percent),

                  // Data receipt section: two flat fields
                  const DataReceiptSection(
                    deviceId: '#10005SFC',
                    extenderId: '#1566HTG',
                  ),

                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
