import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'SignupScreen.dart';

class LoginScreenMock extends StatefulWidget {
  const LoginScreenMock({super.key});
  @override
  State<LoginScreenMock> createState() => _LoginScreenMockState();
}

class _LoginScreenMockState extends State<LoginScreenMock> {
  bool _obscure = true;

  // Field & button sizing
  static const double _kFieldHeight = 45;
  static const double _kMaxFieldWidth = 389;

  // Design aspect ratios (fixed)
  static const double _hdrAR = 120 / 444; // = 0.27027...
  static const double _botAR = 153 / 553; // = 0.2765...

  // Asset paths
  static const String _hdrAsset = 'assets/images/top_header.png';
  static const String _botAsset = 'assets/images/bottom_waves.png';

  // Tank & shadow proportions (derived from your original sizes)
  // Shadow width uses the field width (1.0). Tank ~201/383, heights from originals.
  static const double _shadowWidthFactor = 1.0;
  static const double _shadowHeightPerW = 45 / 383;   // ≈ 0.1175 * width
  static const double _tankWidthFactor   = 201 / 383; // ≈ 0.525 * width
  static const double _tankAR            = 237 / 201; // tankH = tankW * 1.179
  static const double _overlapPerW       = 16 / 383;  // ≈ 0.0418 * width

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // Responsive heights preserving aspect ratios
    final double headerImgH = w * _hdrAR;
    final double bottomImgH = w * _botAR;

    // Field/button width: up to 389dp
    final double horizontalPad = w * 0.08;
    final double available = w - (horizontalPad * 2);
    final double fieldWidth = available > _kMaxFieldWidth ? _kMaxFieldWidth : available;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Top header image
          Positioned(
            top: 0, left: 0, right: 0, height: headerImgH,
            child: IgnorePointer(child: Image.asset(_hdrAsset, fit: BoxFit.fill)),
          ),

          // Bottom waves image
          Positioned(
            left: 0, right: 0, bottom: 0, height: bottomImgH,
            child: IgnorePointer(child: Image.asset(_botAsset, fit: BoxFit.fill)),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPad)
                  .copyWith(bottom: bottomImgH * 0.85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: headerImgH * 0.85),

                  const Text("Hello",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  const Text("Welcome Back",
                      style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.w400)),

                  SizedBox(height: w * 0.06),

                  // Tank + shadow (same layout/size look, simpler math)
                  SizedBox(
                    width: fieldWidth,
                    child: _TankWithShadow(width: fieldWidth),
                  ),

                  SizedBox(height: w * 0.08),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "User Name",
                      style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: fieldWidth,
                    height: _kFieldHeight,
                    child: const TextField(
                      decoration: InputDecoration(hintText: "Enter User Name"),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: fieldWidth,
                    height: _kFieldHeight,
                    child: TextField(
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: "•••• ••••",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: w * 0.06),

                  SizedBox(
                    width: fieldWidth,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.kButtonDark, // keep your theme color
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TankWithShadow extends StatelessWidget {
  final double width;
  const _TankWithShadow({required this.width});

  // Match the constants from the parent for consistency
  static const double _shadowWidthFactor = _LoginScreenMockState._shadowWidthFactor;
  static const double _shadowHeightPerW  = _LoginScreenMockState._shadowHeightPerW;
  static const double _tankWidthFactor   = _LoginScreenMockState._tankWidthFactor;
  static const double _tankAR            = _LoginScreenMockState._tankAR;
  static const double _overlapPerW       = _LoginScreenMockState._overlapPerW;

  @override
  Widget build(BuildContext context) {
    final double sW = width * _shadowWidthFactor;
    final double sH = width * _shadowHeightPerW;
    final double tW = width * _tankWidthFactor;
    final double tH = tW * _tankAR;
    final double overlap = width * _overlapPerW;
    final double stackH = tH + sH - overlap;

    return SizedBox(
      height: stackH,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: tH - overlap,
            width: sW,
            height: sH,
            child: Image.asset('assets/images/tank_shadow.png', fit: BoxFit.fill),
          ),
          SizedBox(
            width: tW,
            height: tH,
            child: Image.asset('assets/images/tankerempty.png', fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
