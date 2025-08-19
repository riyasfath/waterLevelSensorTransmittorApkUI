import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class DeviceTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  /// How many devices are actually available.
  /// Tabs with i >= enabledCount will be disabled.
  final int enabledCount;

  /// Optional: called when a disabled tab is tapped (to show a message).
  final VoidCallback? onDisabledTap;

  const DeviceTabs({
    super.key,
    required this.index,
    required this.onChanged,
    this.enabledCount = 1,
    this.onDisabledTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = const ["device 1", "device 2", "device 3"];

    return Row(
      children: List.generate(items.length, (i) {
        final selected  = index == i;
        final isEnabled = i < enabledCount;

        // Colors for disabled state
        final disabledText  = const Color(0xFFBFC7D1);
        final disabledFill  = const Color(0xFFEDEDED);
        final normalText    = const Color(0xFF4C5865);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < items.length - 1 ? 6 : 0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: isEnabled ? () => onChanged(i) : onDisabledTap, // disabled → message
              child: Container(
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: (selected && isEnabled)
                      ? const LinearGradient(
                    colors: [AppTheme.kBlueLight, AppTheme.kBlueDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: (selected && isEnabled) ? null : (isEnabled ? Colors.white : disabledFill),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (selected && isEnabled)
                        ? Colors.transparent
                        : AppTheme.kDeviceTabBorder,
                    width: 1,
                  ),
                ),
                child: Text(
                  items[i],
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: (selected && isEnabled)
                        ? Colors.white
                        : (isEnabled ? normalText : disabledText),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
