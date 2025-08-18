import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LoginScreenMock extends StatefulWidget {
  const LoginScreenMock({super.key});
  @override
  State<LoginScreenMock> createState() => _LoginScreenMockState();
}

class _LoginScreenMockState extends State<LoginScreenMock> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bottomWaveH = w * 0.36;
    final topWaveH    = w * 0.28;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top curved gradient
          Positioned(
            top: 0, left: 0, right: 0,
            child: SizedBox(
              height: topWaveH,
              child: ClipPath(
                clipper: _TopCurveClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppTheme.kBlueLight, AppTheme.kBlueDark],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom waves
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: SizedBox(
              height: bottomWaveH,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _BottomWaveClipper1(),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppTheme.kBlueLight, AppTheme.kBlueDark],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _BottomWaveClipper2(),
                      child: Container(
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.08)
                  .copyWith(bottom: bottomWaveH * 0.85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: topWaveH * 0.35),
                  const Text("Hello",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  const Text("Welcome Back",
                      style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.w400)),

                  SizedBox(height: w * 0.06),

                  // Tank image
                  SizedBox(
                    width: w * 0.55,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/tankerempty.png',
                          fit: BoxFit.contain,
                          height: w * 0.48,
                        ),
                        SizedBox(height: w * 0.02),
                        Container(
                          height: 10,
                          margin: EdgeInsets.symmetric(horizontal: w * 0.12),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 20,
                                spreadRadius: -6,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: w * 0.08),

                  // Username
                  // Username
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("User Name",
                        style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 6),

                  SizedBox(
                    width: w * 0.84,       // ~84% of screen width
                    height: w * 0.15,      // height responsive (15% of width)
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Enter User Name",
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Password
                  // Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
                  ),
                  const SizedBox(height: 6),

                  SizedBox(
                    width: w * 0.84,       // same as username
                    height: w * 0.15,
                    child: TextField(
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: "••••••••",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: w * 0.06),

                  // CTA Button with #012A6A
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.kButtonDark,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      child: const Text("Sign Up", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500, color: Colors.white)),
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

// --- Clippers ---
class _TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width, h = s.height;
    return Path()
      ..lineTo(0, h * 0.20)
      ..quadraticBezierTo(w * 0.50, h * 0.45, w, h * 0.16)
      ..lineTo(w, 0)
      ..close();
  }
  @override
  bool shouldReclip(_) => false;
}

class _BottomWaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width, h = s.height;
    return Path()
      ..moveTo(0, h * 0.30)
      ..quadraticBezierTo(w * 0.25, h * 0.15, w * 0.50, h * 0.28)
      ..quadraticBezierTo(w * 0.78, h * 0.45, w, h * 0.25)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
  }
  @override
  bool shouldReclip(_) => false;
}

class _BottomWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width, h = s.height;
    return Path()
      ..moveTo(0, h * 0.55)
      ..quadraticBezierTo(w * 0.28, h * 0.35, w * 0.52, h * 0.60)
      ..lineTo(w, h * 0.35)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
  }
  @override
  bool shouldReclip(_) => false;
}
