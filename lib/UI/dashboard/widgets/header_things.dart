import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class headerThings extends StatelessWidget {
  final String date, time;
  final VoidCallback onSettings;
  const headerThings({
    super.key,
    required this.date,
    required this.time,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 82,
      collapsedHeight: 66,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.primary,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: Padding(
          // positions the row near the bottom like your figma
          padding: const EdgeInsets.only(left: 8, right: 4, bottom: 14),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left spacer balances the icon width to keep the text truly centered
                const SizedBox(width: 40),

                // Centered date+time
                Expanded(
                  child: Text(
                    "$date   $time",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),

                // Settings icon on the same line, right-aligned
                IconButton(
                  onPressed: onSettings,
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  splashRadius: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
