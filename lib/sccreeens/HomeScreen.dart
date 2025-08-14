import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedDevice = 0;
  int selectedWaterPos = 1; // 25,50,75,100 -> 0..3
  final percent = 75; // plug your live value here
  final battery = 65; // plug your live value here

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Smaller header; only date+time centered
          _HeaderCompact(
            date: "12/08/2025",
            time: "4:39pm",
            onSettings: () {}, // keep the gear like your mock
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DeviceTabs(
                    index: selectedDevice,
                    onChanged: (i) => setState(() => selectedDevice = i),
                  ),
                  const SizedBox(height: 12),
                  _TankCard(percent: percent),

                  // Last update (unchanged)
                  _LabeledInfoRow(
                    title: "Last update",
                    left: "Date : 12/8/2025",
                    right: "Time : 6:05am",
                  ),

                  // 🔋 Battery as Last-update style field
                  _BatteryField(level: battery),

                  // Water position (unchanged)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "water position",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            children: List.generate(4, (i) {
                              const labels = ["25%", "50%", "75%", "100%"];
                              final selected = selectedWaterPos == i;
                              return ChoiceChip(
                                label: Text(labels[i]),
                                selected: selected,
                                onSelected:
                                    (_) => setState(() => selectedWaterPos = i),
                                selectedColor: AppTheme.primary,
                                labelStyle: TextStyle(
                                  color: selected ? Colors.white : null,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Key/Value details (unchanged)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _KeyValueRow(title: "Data receipt type", value: ""),
                          SizedBox(height: 6),
                          _KeyValueRow(title: "Device id", value: "#10005FC"),
                          SizedBox(height: 6),
                          _KeyValueRow(title: "Extender id", value: "#15684TG"),
                        ],
                      ),
                    ),
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

/// Compact header without status icons; only date + time centered.
class _HeaderCompact extends StatelessWidget {
  final String date, time;
  final VoidCallback onSettings;
  const _HeaderCompact({
    required this.date,
    required this.time,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    const appBarColor = Color(0xFF0181D7); // fixed color

    return SliverAppBar(
      pinned: true,
      expandedHeight: 82,
      collapsedHeight: 66,
      automaticallyImplyLeading: false,
      backgroundColor: appBarColor,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Date & Time - Centered horizontally, slightly above bottom
            Positioned(
              bottom: 22, // moved up from 6
              left: 0,
              right: 0,
              child: Text(
                "$date   $time",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),

            // Settings Icon - aligned vertically with date/time
            Positioned(
              bottom: 9, // matches date/time position
              right: -2, // still slightly out for max edge placement
              child: IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: onSettings,
                tooltip: 'Settings',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                visualDensity: VisualDensity.compact,
                splashRadius: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _DeviceTabs({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = const ["device 1", "device 2", "device 3"];
    return Row(
      children: List.generate(items.length, (i) {
        final selected = index == i;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < items.length - 1 ? 8 : 0),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () => onChanged(i),
              child: Container(
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: selected
                      ? const LinearGradient(
                    colors: [Color(0xFF6DC1FD), Color(0xFF095C97)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: selected ? null : Colors.white, // keep white for unselected
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected ? Colors.transparent : const Color(0xFFE0E7EF),
                  ),
                ),
                child: Text(
                  items[i],
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF4C5865),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TankCard extends StatelessWidget {
  final int percent;
  const _TankCard({required this.percent});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 1.05,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // (no Card, no white backdrop)

            // Soft ground ellipse
            Positioned(
              left: 28,
              right: 28,
              bottom: 6,
              child: SizedBox(
                height: 18,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 18,
                        spreadRadius: -8,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tank art (transparent PNG) — reduced size
            FractionallySizedBox(
              widthFactor: 0.78, // shrink image
              child: Image(
                image: AssetImage('assets/images/tankerempty.png'),
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),

            // % overlay
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "75%",
                style: TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledInfoRow extends StatelessWidget {
  final String title, left, right;
  const _LabeledInfoRow({
    required this.title,
    required this.left, // e.g. "12/8/2025"
    required this.right, // e.g. "6:50am"
  });

  static const _valueStyle = TextStyle(
    color: Color(0xB5000000), // #000000B5 (AA RRGGBB in Flutter)
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  InputDecoration _decoration(String suffix) => InputDecoration(
    isDense: true,
    filled: true,
    fillColor: const Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    suffixText: suffix,
    suffixStyle: _valueStyle,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            initialValue: left,
            style: _valueStyle,
            decoration: _decoration(right),
          ),
        ],
      ),
    );
  }
}

class _BatteryField extends StatelessWidget {
  final int level; // 0-100
  const _BatteryField({required this.level});

  static const _valueStyle = TextStyle(
    color: Color(0xB5000000),
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  InputDecoration _decoration(BuildContext context) => InputDecoration(
    isDense: true,
    filled: true,
    fillColor: const Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    // Right side: battery icon + percentage
    suffixIcon: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BatteryIcon(level: level),
          const SizedBox(width: 8),
          Text("$level%", style: _valueStyle),
        ],
      ),
    ),
    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Battery level',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            initialValue: "", // keep empty to highlight suffix content
            style: _valueStyle,
            decoration: _decoration(context),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF6B7178),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  final String title, value;
  const _KeyValueRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: const TextStyle(color: Color(0xFF6B7178))),
        ),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF9AA3AE),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _BatteryIcon extends StatelessWidget {
  final int level; // 0-100
  const _BatteryIcon({required this.level});

  @override
  Widget build(BuildContext context) {
    final width = 30.0;
    final height = 14.0;
    final fill = (level.clamp(0, 100)) / 100.0;

    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB7C3D0)),
            borderRadius: BorderRadius.circular(3),
          ),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: fill,
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: level < 25
                    ? Colors.red
                    : (level < 50 ? Colors.orange : Colors.green),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        Container(
          width: 3,
          height: 8,
          margin: const EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFB7C3D0),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }
}
