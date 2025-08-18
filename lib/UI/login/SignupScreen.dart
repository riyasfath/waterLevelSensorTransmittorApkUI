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

  // Top & bottom image design sizes (for aspect ratios)
  static const double _hdrDesignW = 444, _hdrDesignH = 120; // header image
  static const double _botDesignW = 553, _botDesignH = 153; // bottom image
  static const String _hdrAsset = 'assets/images/top_header.png';
  static const String _botAsset = 'assets/images/bottom_waves.png';

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // Responsive heights preserving the images’ aspect ratios
    final double headerImgH = w * (_hdrDesignH / _hdrDesignW);
    final double bottomImgH = w * (_botDesignH / _botDesignW);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- TOP: header image (replaces AppBar/clipper) ---
          Positioned(
            top: 0, left: 0, right: 0,
            height: headerImgH,
            child: IgnorePointer(
              child: Image.asset(_hdrAsset, fit: BoxFit.fill),
            ),
          ),

          // --- BOTTOM: waves image (replaces clippers) ---
          Positioned(
            left: 0, right: 0, bottom: 0,
            height: bottomImgH,
            child: IgnorePointer(
              child: Image.asset(_botAsset, fit: BoxFit.fill),
            ),
          ),

          // --- CONTENT ---
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.08)
              // leave space so content doesn’t collide with bottom waves
                  .copyWith(bottom: bottomImgH * 0.85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // push form below the curved part of the top image
                  SizedBox(height: headerImgH * 0.82),

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
                        backgroundColor: AppTheme.kButtonDark,
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
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
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

