import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class DeviceTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const DeviceTabs({super.key, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = const ["device 1", "device 2", "device 3"];
    return Row(
      children: List.generate(items.length, (i) {
        final selected = index == i;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < items.length - 1 ? 6 : 0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onChanged(i),
              child: Container(
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: selected
                      ? const LinearGradient(
                    colors: [AppTheme.kBlueLight, AppTheme.kBlueDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: selected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected
                        ? Colors.transparent
                        : AppTheme.kDeviceTabBorder, // ← your color
                    width: 1,
                  ),
                ),
                child: Text(
                  items[i],
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF4C5865),
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
