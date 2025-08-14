import 'package:flutter/material.dart';
import 'battery_icon.dart';

/// Flat battery row (no Card, no progress bar) to match LabeledInfoRow.
/// Icon on the left, percentage at the far right inside a single TextFormField.
class BatteryProgressCard extends StatelessWidget {
  final int level; // 0-100
  // kept for API compatibility; not used now (no progress bar / surface)
  final Color surfaceColor;

  const BatteryProgressCard({
    super.key,
    required this.level,
    required this.surfaceColor,
  });

  static const _valueStyle = TextStyle(
    color: Color(0xB5000000), // #000000B5
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  InputDecoration _decoration() => const InputDecoration(
    isDense: true,
    filled: true,
    fillColor: Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      // same outer padding as LabeledInfoRow so everything feels like one panel
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("battery level",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            initialValue: '', // no left text; show only the icon on the left
            style: _valueStyle,
            textAlignVertical: TextAlignVertical.center,
            decoration: _decoration().copyWith(
              // battery icon on the left
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: BatteryIcon(level: 65), // level here doesn't affect suffix
              ),
              prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),

              // percentage on the far right — use suffixIcon to force edge alignment
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text('$level %', style: _valueStyle),
              ),
              suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
            ),
          ),
        ],
      ),
    );
  }
}
