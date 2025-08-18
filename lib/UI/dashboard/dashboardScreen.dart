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
  final int percent = 75; // live value 0..100
  final int battery = 65; // live value 0..100

  // Layout knobs
  static const double _tankH = 287;
  static const double _tankW = 245;
  static const double _tankTop = 20;    // moved a little more up (smaller = higher)
  static const double _overlap  = 37;  // DO NOT CHANGE

  @override
  Widget build(BuildContext context) {
    // Height math so the next section sits right after the overlapped row.
    const double rowHeightEstimate = 48; // Text + field
    const double bottomPad = 2;
    final double extraBelow = (rowHeightEstimate - _overlap + bottomPad);
    final double stackHeight =
        _tankTop + _tankH + (extraBelow > 0 ? extraBelow : 0);

    return Scaffold(
      backgroundColor: Colors.white,
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
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tabs + Tank + Last update
                  SizedBox(
                    height: stackHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Tabs
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: DeviceTabs(
                            index: selectedDevice,
                            onChanged: (i) => setState(() => selectedDevice = i),
                          ),
                        ),
                        // Tank
                        Positioned(
                          top: _tankTop,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TankCard(
                              percent: percent,
                              height: _tankH,
                              width: _tankW,
                              imageScale: 0.72,

                              // Base image under tank (exact 383x45)
                              baseImageAsset: 'assets/images/tank_shadow.png',
                              baseFixedWidth: 383,
                              baseFixedHeight: 45,
                              baseGap: 0, // adjust if you need it tighter/looser

                              // Subtle shadow settings
                              showShadow: true,
                              shadowWidthFactor: 0.55,
                              shadowHeight: 12,
                              shadowBlur: 10,
                              shadowSpread: -4,
                              shadowOpacity: 0.06,
                              shadowGlowOpacity: 0.15,
                            ),
                          ),
                        ),
                        // Last update (overlapped up into tank)
                        const Positioned(
                          top: _tankTop + _tankH - _overlap,
                          left: 0,
                          right: 0,
                          child: LabeledInfoRow(
                            title: "Last update",
                            left: "12/08/2025",
                            right: "6:05 AM",
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Battery level
                  BatteryProgressCard(
                    level: battery,
                    surfaceColor: Colors.transparent,
                  ),

                  // Water position & Data receipt
                  WaterPositionCard(level: percent),
                  const DataReceiptSection(
                    deviceId: '#10005SFC',
                    extenderId: '#1566HTG',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
