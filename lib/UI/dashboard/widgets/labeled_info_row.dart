import 'package:flutter/material.dart';

/// Flat row (no Card) so multiple rows stack with no visible gaps.
/// Shows [title], and a single TextFormField with:
/// - left/start: [left] text (e.g., date)
/// - right/end:  [right] text (e.g., time)
class LabeledInfoRow extends StatelessWidget {
  final String title, left, right; // left = start, right = end
  const LabeledInfoRow({
    super.key,
    required this.title,
    required this.left,
    required this.right,
  });

  // Inside-the-field text style (both left & right)
  static const _valueStyle = TextStyle(
    color: Color(0xB5000000), // #000000B5
    fontSize: 14,
    fontWeight: FontWeight.w600,
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
    suffixText: suffix,       // right text
    suffixStyle: _valueStyle, // same style as left
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      // tight spacing so multiple rows feel like one continuous panel
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            initialValue: left,     // left/start text
            style: _valueStyle,     // <-- #000000B5, 14px
            decoration: _decoration(right), // right/end text
          ),
        ],
      ),
    );
  }
}
