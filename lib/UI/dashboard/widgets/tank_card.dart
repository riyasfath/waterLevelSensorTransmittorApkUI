import 'package:flutter/material.dart';

class TankCard extends StatelessWidget {
  final int percent;
  const TankCard({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 1.05,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 28,
              right: 28,
              bottom: 6,
              child: SizedBox(
                height: 18,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 18,
                        spreadRadius: -8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Make sure this path exists in pubspec.yaml
            FractionallySizedBox(
              widthFactor: 0.78,
              child: Image(
                image: AssetImage('assets/images/tankerempty.png'),
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "75%",
                style: TextStyle(
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
