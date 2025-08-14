import 'package:flutter/material.dart';

class KeyValueRow extends StatelessWidget {
  final String title, value;
  const KeyValueRow({super.key, required this.title, required this.value});

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
