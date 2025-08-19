import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:battery_plus/battery_plus.dart';
import 'package:waterlevelcopy/UI/dashboard/widgets/battery_field.dart';
import 'package:waterlevelcopy/UI/dashboard/widgets/key_values_card.dart';
import 'package:waterlevelcopy/UI/historyScreen/historyScreen.dart';
import 'package:waterlevelcopy/UI/settings/settingsScreen.dart';

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
  // Selected device tab
  int selectedDevice = 0;

  // Demo water % (0..100)
  final int percent = 75;

  // Phone battery %
  final Battery _battery = Battery();
  int _batteryPct = 0;

  // Live clock strings + timer
  Timer? _clock;
  String _dateStr = '';
  String _timeStr = '';

  // If only one device is connected, keep others disabled.
  // (You can later set this based on SharedPreferences list length.)
  final int _enabledDeviceCount = 1;

  // Layout knobs
  static const double _tankH = 287;
  static const double _tankW = 245;
  static const double _tankTop = 20; // move up (smaller = higher)
  static const double _overlap = 37; // DO NOT CHANGE

  @override
  void initState() {
    super.initState();
    _updateClock();
    _updateBattery();
    // Update every 30s (clock + battery)
    _clock = Timer.periodic(const Duration(seconds: 30), (_) {
      _updateClock();
      _updateBattery();
    });
  }

  @override
  void dispose() {
    _clock?.cancel();
    super.dispose();
  }

  // Make "dd/MM/yyyy" + "hh:mm am/pm"
  void _updateClock() {
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    final date = '${two(now.day)}/${two(now.month)}/${now.year}';
    final h12 = (now.hour % 12 == 0) ? 12 : (now.hour % 12);
    final time = '$h12:${two(now.minute)} ${now.hour >= 12 ? 'pm' : 'am'}';
    setState(() {
      _dateStr = date;
      _timeStr = time;
    });
  }

  // Read phone battery % (0..100)
  Future<void> _updateBattery() async {
    try {
      final lvl = await _battery.batteryLevel;
      if (!mounted) return;
      setState(() => _batteryPct = lvl);
    } catch (_) {
      // ignore if not supported (e.g., some emulators)
    }
  }

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
          // Header shows live date/time
          headerThings(
            date: _dateStr,
            time: _timeStr,
            onSettings: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),

          // Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tabs + Tank + Last update (overlapped row)
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
                            enabledCount: _enabledDeviceCount,   // <-- disable others
                            onChanged: (i) => setState(() => selectedDevice = i),
                            onDisabledTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Only one device connected')),
                              );
                            },
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
                              baseGap: 0,
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

                        // Last update (overlaps up into tank)
                        Positioned(
                          top: _tankTop + _tankH - _overlap,
                          left: 0,
                          right: 0,
                          child: LabeledInfoRow(
                            title: "Last update",
                            left: _dateStr.isEmpty ? '—' : _dateStr,
                            right: _timeStr.isEmpty ? '—' : _timeStr,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Battery level (phone battery %)
                  BatteryProgressCard(
                    level: _batteryPct,
                    surfaceColor: Colors.transparent,
                  ),

                  // Water position & Data receipt (static demo IDs)
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
