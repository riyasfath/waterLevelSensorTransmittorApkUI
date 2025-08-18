import 'package:flutter/material.dart';

/// "Data receipt" section styled like your figma:
/// - Title "Data receipt"
/// - Two flat fields with left label and right value inside the same box.
class DataReceiptSection extends StatelessWidget {
  final String deviceId;
  final String extenderId;

  const DataReceiptSection({
    super.key,
    required this.deviceId,
    required this.extenderId,
  });

  static const _titleStyle =
  TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  static const _labelStyle = TextStyle(
    color: Color(0xFF6B7178),
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const _valueStyle = TextStyle(
    color: Color(0xB5000000), // #000000B5
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  InputDecoration _decoration(String right) => InputDecoration(
    isDense: true,
    filled: true,
    fillColor: const Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    suffixText: right,
    suffixStyle: _valueStyle,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Data receipt type', style: _titleStyle),
          const SizedBox(height: 8),

          // Device id field
          TextFormField(
            readOnly: true,
            initialValue: 'Device id',
            style: _labelStyle,
            decoration: _decoration(deviceId),
          ),
          const SizedBox(height: 6),

          // Extender id field
          TextFormField(
            readOnly: true,
            initialValue: 'Extender id',
            style: _labelStyle,
            decoration: _decoration(extenderId),
          ),
        ],
      ),
    );
  }
}
