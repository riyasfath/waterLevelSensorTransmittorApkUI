import 'package:flutter/material.dart';

/// Display-only water position (no selection / no tick).
/// Highlights the nearest step (25/50/75/100) based on [level].
/// Active chip uses gradient #5E9DF2 → #365B8C; others use text #7D7575.
class WaterPositionCard extends StatelessWidget {
  final int level; // 0..100 current measured water level

  const WaterPositionCard({
    super.key,
    required this.level,
  });

  static const _titleStyle =
  TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  static const _offText = TextStyle(
    color: Color(0xFF7D7575), // other chips text color
    fontWeight: FontWeight.w600,
  );

  static const _onText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    // discrete steps shown as chips
    const steps = [25, 50, 75, 100];

    // nearest step to measured level
    final activeIndex = _nearestIndex(level, steps);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('water position', style: _titleStyle),
          const SizedBox(height: 8),
          Row(
            children: List.generate(steps.length, (i) {
              final selected = i == activeIndex;
              return Expanded(
                child: Padding(
                  // keep buttons "much close" to each other
                  padding: EdgeInsets.only(right: i < steps.length - 1 ? 6 : 0),
                  child: _Chip(
                    label: '${steps[i]}%',
                    selected: selected,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  static int _nearestIndex(int value, List<int> steps) {
    int bestIdx = 0;
    int bestDiff = 1 << 30;
    for (var i = 0; i < steps.length; i++) {
      final d = (steps[i] - value).abs();
      if (d < bestDiff) {
        bestDiff = d;
        bestIdx = i;
      }
    }
    return bestIdx;
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  const _Chip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      alignment: Alignment.center,
      decoration: selected
          ? BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5E9DF2), Color(0xFF365B8C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      )
          : BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: selected ? WaterPositionCard._onText : WaterPositionCard._offText),
    );
  }
}
