import 'package:flutter/material.dart';

/// TankCard — shows a tank PNG with a base image below and a faint shadow.
class TankCard extends StatelessWidget {
  final int percent;
  final double height;
  final double imageScale;

  /// If provided, the card will be this wide (e.g., 245).
  /// If null, it will expand to the available width.
  final double? width;

  /// Base image placed under the tank
  final String baseImageAsset;

  /// Exact size for the base art (logical px). If null, it will scale by widthFactor.
  final double? baseFixedWidth;   // e.g., 383
  final double? baseFixedHeight;  // e.g., 45

  /// Used only if baseFixedWidth/Height are null.
  final double baseWidthFactor;   // 0..1 of available width

  /// Vertical fine-tune gap between tank bottom and base (+ down, - up)
  final double baseGap;

  /// Shadow controls
  final bool showShadow;
  final double shadowWidthFactor;
  final double shadowHeight;
  final double shadowBlur;
  final double shadowSpread;
  final double shadowOpacity;     // fill
  final double shadowGlowOpacity; // boxShadow color

  const TankCard({
    super.key,
    required this.percent,
    this.height = 200,
    this.imageScale = 0.72,
    this.width,
    this.baseImageAsset = 'assets/images/tank_base.png',
    this.baseFixedWidth,
    this.baseFixedHeight,
    this.baseWidthFactor = 0.6,
    this.baseGap = 0,
    this.showShadow = true,
    this.shadowWidthFactor = 0.55,
    this.shadowHeight = 12,
    this.shadowBlur = 10,
    this.shadowSpread = -4,
    this.shadowOpacity = 0.06,
    this.shadowGlowOpacity = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    // Distance from tank image bottom to card bottom when centered via FractionallySizedBox
    final double imageBottomFromCardBottom = (height * (1 - imageScale)) / 2;

    // Where to position the base + shadow so they hug the tank bottom
    final double computedBottom =
    (imageBottomFromCardBottom - baseGap).clamp(0.0, height);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none, // allow base to be wider than the card
          children: [
            // Faint ground shadow (below the base)
            if (showShadow)
              Positioned(
                bottom: computedBottom,
                left: 0,
                right: 0,
                child: FractionallySizedBox(
                  widthFactor: shadowWidthFactor,
                  child: SizedBox(
                    height: shadowHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(shadowOpacity),
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(shadowGlowOpacity),
                            blurRadius: shadowBlur,
                            spreadRadius: shadowSpread,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Base image (exact 383x45)
            Positioned(
              bottom: computedBottom,
              child: _buildBase(),
            ),

            // Tank art (transparent PNG)
            FractionallySizedBox(
              widthFactor: imageScale,
              heightFactor: imageScale,
              child: const Image(
                image: AssetImage('assets/images/tankerempty.png'),
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),

            // % overlay
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBase() {
    if (baseFixedWidth != null && baseFixedHeight != null) {
      return SizedBox(
        width: baseFixedWidth,
        height: baseFixedHeight,
        child: Image.asset(
          baseImageAsset,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      );
    }
    return FractionallySizedBox(
      widthFactor: baseWidthFactor,
      child: Image.asset(
        baseImageAsset,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
