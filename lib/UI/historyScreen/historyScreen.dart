import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const _blue = Color(0xFF0181D7);
  static const _pill = Color(0xFFF1F4F8);

  @override
  Widget build(BuildContext context) {
    final rows = <_HistoryRow>[
      _HistoryRow('10/5/2025', '10:30am', '450 Ltr', '#B56GHTG'),
      _HistoryRow('10/5/2025', '9:00am',  '410 Ltr', '#B56GHTG'),
      _HistoryRow('10/5/2025', '8:30am',  '390 Ltr', '#B56GHTG'),
      _HistoryRow('10/5/2025', '8:00am',  '220 Ltr', '#B56GHTG'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 88,
        backgroundColor: _blue,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'History',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 48), // balance right side
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          children: [
            // Header pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: _pill, borderRadius: BorderRadius.circular(8),
              ),
              child: _row(
                const Text('Date', style: _hStyle),
                const Text('Time', style: _hStyle),
                const Text('Water Level', style: _hStyle),
                const Text('Extender Id', style: _hStyle),
              ),
            ),
            const SizedBox(height: 8),
            // Rows
            Expanded(
              child: ListView.separated(
                itemCount: rows.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final r = rows[i];
                  return _row(
                    Text(r.date, style: _rStyle),
                    Text(r.time, style: _rStyle),
                    Text(r.level, style: _rStyle),
                    Text(r.extId, style: _rStyle),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4 equal columns with small left/right padding
  static Widget _row(Widget c1, Widget c2, Widget c3, Widget c4) {
    return Row(
      children: [
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10), child: c1)),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10), child: c2)),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10), child: c3)),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10), child: c4)),
      ],
    );
  }
}

// text styles
const _hStyle = TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.black87);
const _rStyle = TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500);

// model
class _HistoryRow {
  final String date, time, level, extId;
  const _HistoryRow(this.date, this.time, this.level, this.extId);
}
