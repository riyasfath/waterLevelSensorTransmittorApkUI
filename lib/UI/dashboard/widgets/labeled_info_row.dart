import 'package:flutter/material.dart';

/// Flat row (no Card). Title + one field showing left/right values.
class LabeledInfoRow extends StatelessWidget {
  final String title, left, right; // left = start, right = end
  const LabeledInfoRow({
    super.key,
    required this.title,
    required this.left,
    required this.right,
  });

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
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    suffixText: suffix,
    suffixStyle: _valueStyle,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
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
