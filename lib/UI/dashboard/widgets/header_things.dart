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
    const appBarColor = AppTheme.primary;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 82,
      collapsedHeight: 66,
      automaticallyImplyLeading: false,
      backgroundColor: appBarColor,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 22,
              left: 0,
              right: 0,
              child: Text(
                "$date   $time",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),
            Positioned(
              bottom: 9,
              right: -2,
              child: IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: onSettings,
                tooltip: 'Settings',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                visualDensity: VisualDensity.compact,
                splashRadius: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
