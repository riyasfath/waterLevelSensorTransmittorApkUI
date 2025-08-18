import 'package:flutter/material.dart';
import 'package:waterlevelcopy/UI/dashboard/dashboardScreen.dart';
import '../../theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bottomWaveH = w * 0.36;
    final topWaveH = w * 0.28;

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

          // Bottom layered waves
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
                      child: Container(color: Colors.white.withOpacity(0.12)),
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
                  SizedBox(height: topWaveH * 0.30),
                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: w * 0.06),

                  // ----- User Name -----
                  const _Label("User Name"),
                  const SizedBox(height: 6),
                  _SizedField(
                    width: w * 0.84,
                    height: w * 0.15,
                    child: const TextField(
                      decoration: InputDecoration(hintText: "Enter User Name"),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ----- Password -----
                  const _Label("Password"),
                  const SizedBox(height: 6),
                  _SizedField(
                    width: w * 0.84,
                    height: w * 0.15,
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
                  const SizedBox(height: 12),

                  // ----- Email -----
                  const _Label("Email"),
                  const SizedBox(height: 6),
                  _SizedField(
                    width: w * 0.84,
                    height: w * 0.15,
                    child: const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Enter"),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ----- Store Name -----
                  const _Label("Store Name"),
                  const SizedBox(height: 6),
                  _SizedField(
                    width: w * 0.84,
                    height: w * 0.15,
                    child: const TextField(
                      decoration: InputDecoration(hintText: "Enter Store Name"),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ----- Water Tank Model -----
                  const _Label("Water Tank Model"),
                  const SizedBox(height: 6),
                  _SizedField(
                    width: w * 0.84,
                    height: w * 0.15,
                    child: const TextField(
                      decoration: InputDecoration(hintText: "Enter Tank Model"),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ----- Device Id with QR + Add Device -----
                  // ----- Device Id -----
                  const _Label("Device Id"),
                  const SizedBox(height: 6),
                  _SizedField(
                    width: w * 0.84,
                    height: w * 0.15,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Scan Qr Code",
                        suffixIcon: IconButton(
                          onPressed: () {}, // TODO: scan action
                          icon: const Icon(Icons.qr_code_scanner_outlined),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {}, // TODO: add device action
                      child: const Text("Add Device", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  // const SizedBox(height: 12),


                  // ----- Extender Id with QR + Add Device -----
                  // ----- Extender Id -----
                  const _Label("Extender Id"),
                  const SizedBox(height: 6),
                  _SizedField(
                    width: w * 0.84,
                    height: w * 0.15,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Scan Qr Code",
                        suffixIcon: IconButton(
                          onPressed: () {}, // TODO: scan action
                          icon: const Icon(Icons.qr_code_scanner_outlined),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {}, // TODO: add device action
                      child: const Text("Add Device", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  const SizedBox(height: 12),


                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.kButtonDark, // #012A6A
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
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

// ---------- Small helpers ----------
class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style: const TextStyle(
              fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500)),
    );
  }
}

class _SizedField extends StatelessWidget {
  final double? width;
  final double height;
  final Widget child;
  const _SizedField({this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height, child: child);
  }
}

// ---------- Reused clippers ----------
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
