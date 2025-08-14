import 'package:flutter/material.dart';

/// Small static battery glyph used as a prefix icon.
class BatteryIcon extends StatelessWidget {
  final int level; // 0-100
  const BatteryIcon({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final width = 30.0;
    final height = 14.0;
    final fill = (level.clamp(0, 100)) / 100.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // battery body
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
        // battery cap
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
