import 'package:flutter/material.dart';

/// TankCard — now supports explicit width.
class TankCard extends StatelessWidget {
  final int percent;
  final double height;
  final double imageScale;

  /// If provided, the card will be this wide (e.g., 245).
  /// If null, it will expand to the available width.
  final double? width;

  final double shadowWidthFactor;
  final double shadowHeight;
  final double shadowGap;
  final double shadowBlur;
  final double shadowSpread;

  const TankCard({
    super.key,
    required this.percent,
    this.height = 200,
    this.imageScale = 0.72,
    this.width, // <— new
    this.shadowWidthFactor = 0.52,
    this.shadowHeight = 12,
    this.shadowGap = 3,
    this.shadowBlur = 14,
    this.shadowSpread = -6,
  });

  @override
  Widget build(BuildContext context) {
    final double imageBottomFromCardBottom = (height * (1 - imageScale)) / 2;
    final double computedBottom =
    (imageBottomFromCardBottom - shadowGap).clamp(0.0, height);

    return Padding(
      // compact vertical gap
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SizedBox(
        height: height,
        width: width, // <— respect explicit width if given
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ground shadow ellipse
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
                      color: Colors.black12,
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: shadowBlur,
                          spreadRadius: shadowSpread,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
}
