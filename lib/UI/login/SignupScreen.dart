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

  final String topImage = "assets/images/top_header.png";
  final String bottomImage = "assets/images/bottom_waves.png";

  // Field decoration from Figma
  final InputDecoration _fxDecoration = const InputDecoration(
    filled: true,
    fillColor: Color(0x42D9D9D9), // #D9D9D9 26%
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  );

  static const double _fieldW = 360;
  static const double _fieldH = 45;
  static const double _gapTop = 29;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // calculate header and footer image height by aspect ratio
    final double headerImgH = w * (120 / 444);
    final double bottomImgH = w * (153 / 553);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- Top image ---
          Positioned(
            top: 0, left: 0, right: 0,
            height: headerImgH,
            child: Image.asset(topImage, fit: BoxFit.fill),
          ),

          // --- Bottom image ---
          Positioned(
            bottom: 0, left: 0, right: 0,
            height: bottomImgH,
            child: Image.asset(bottomImage, fit: BoxFit.fill),
          ),

          // --- Scrollable white form, inside the space between header and footer ---
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: headerImgH * 0.8,   // push down below top curve
                bottom: bottomImgH * 0.9, // stop above bottom waves
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white, // Pure white background
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white, // Double ensure pure white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Create Account",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                        ),

                        // === User Name ===
                        const SizedBox(height: _gapTop),
                        _label("User Name"),
                        _box(TextField(
                          decoration: _fxDecoration.copyWith(hintText: "Enter User Name"),
                        )),

                        // === Password ===
                        const SizedBox(height: _gapTop),
                        _label("Password"),
                        _box(TextField(
                          obscureText: _obscure,
                          decoration: _fxDecoration.copyWith(
                            hintText: "•••• ••••",
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscure = !_obscure),
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                            ),
                          ),
                        )),

                        // === Email ===
                        const SizedBox(height: _gapTop),
                        _label("Email"),
                        _box(TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: _fxDecoration.copyWith(hintText: "Enter"),
                        )),

                        // === Store Name ===
                        const SizedBox(height: _gapTop),
                        _label("Store Name"),
                        _box(TextField(
                          decoration: _fxDecoration.copyWith(hintText: "Enter Store Name"),
                        )),

                        // === Tank Model ===
                        const SizedBox(height: _gapTop),
                        _label("Water Tank Model"),
                        _box(TextField(
                          decoration: _fxDecoration.copyWith(hintText: "Enter Tank Model"),
                        )),

                        // === Device Id ===
                        const SizedBox(height: _gapTop),
                        _label("Device Id"),
                        _box(TextField(
                          decoration: _fxDecoration.copyWith(
                            hintText: "Scan Qr Code",
                            suffixIcon: const Icon(Icons.qr_code_scanner_outlined),
                          ),
                        )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Add Device", style: TextStyle(fontSize: 12)),
                          ),
                        ),

                        // === Extender Id ===
                        const SizedBox(height: _gapTop),
                        _label("Extender Id"),
                        _box(TextField(
                          decoration: _fxDecoration.copyWith(
                            hintText: "Scan Qr Code",
                            suffixIcon: const Icon(Icons.qr_code_scanner_outlined),
                          ),
                        )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Add Device", style: TextStyle(fontSize: 12)),
                          ),
                        ),

                        // === Login Button ===
                        const SizedBox(height: _gapTop),
                        SizedBox(
                          width: _fieldW,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.kButtonDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const DashboardScreen()),
                              );
                            },
                            child: const Text("Login", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _box(Widget child) {
    return SizedBox(width: _fieldW, height: _fieldH, child: child);
  }
}