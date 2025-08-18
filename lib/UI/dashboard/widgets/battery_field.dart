import 'package:flutter/material.dart';
import 'battery_icon.dart';

/// Battery row: label on top, field with icon left and % right.
class BatteryProgressCard extends StatelessWidget {
  final int level; // 0-100
  final Color surfaceColor; // kept for API compatibility

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
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      // TOP = 2 keeps it close to "Last update"
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("battery level",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          TextFormField(
            readOnly: true,
            initialValue: '',
            style: _valueStyle,
            textAlignVertical: TextAlignVertical.center,
            decoration: _decoration().copyWith(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BatteryIcon(level: level),
              ),
              prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
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
