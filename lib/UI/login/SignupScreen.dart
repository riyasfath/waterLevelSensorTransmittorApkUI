import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- NEW
import 'package:waterlevelcopy/UI/dashboard/dashboardScreen.dart';
import '../../theme/app_theme.dart';
import 'QR_scanScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // --- Form key ---
  final _formKey = GlobalKey<FormState>();

  // --- Controllers ---
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _storeCtrl = TextEditingController();
  final _tankCtrl  = TextEditingController();

  // Read-only "display" controllers (show last scanned value)
  final _devIdDisplayCtrl = TextEditingController();
  final _extIdDisplayCtrl = TextEditingController();

  bool _obscure = true;

  // Multi-scan lists
  final List<String> _deviceIds   = [];
  final List<String> _extenderIds = [];

  // ---- SharedPrefs Keys (centralized) ----
  static const _kUserName     = 'sp_user_name';
  static const _kPassword     = 'sp_password';
  static const _kEmail        = 'sp_email';
  static const _kStoreName    = 'sp_store_name';
  static const _kTankModel    = 'sp_tank_model';
  static const _kDeviceIds    = 'sp_device_ids';
  static const _kExtenderIds  = 'sp_extender_ids';
  static const _kLastLoginAt  = 'sp_last_login_at';
  static const _kLoggedIn     = 'sp_logged_in';

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    _emailCtrl.dispose();
    _storeCtrl.dispose();
    _tankCtrl.dispose();
    _devIdDisplayCtrl.dispose();
    _extIdDisplayCtrl.dispose();
    super.dispose();
  }

  final String topImage = "assets/images/top_header.png";
  final String bottomImage = "assets/images/bottom_waves.png";

  // Field decoration from Figma (tweaked with isDense + error style)
  final InputDecoration _fxDecoration = const InputDecoration(
    filled: true,
    fillColor: Color(0x42D9D9D9), // #D9D9D9 26%
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide.none,
    ),
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    errorStyle: TextStyle(fontSize: 12, height: 1.0),
  );

  static const double _fieldW = 360; // width only; no fixed height anymore
  static const double _gapTop = 29;

  // --- Validators ---
  String? _required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label is required' : null;

  final _emailRegex = RegExp(r'^[\w\.\-]+@[\w\.\-]+\.\w+$');
  String? _emailVal(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }

  String? _passwordVal(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Min 6 characters';
    return null;
  }

  // For Device/Extender: list-based validators
  String? _deviceListValidator(_) =>
      _deviceIds.isEmpty ? 'At least one Device Id is required' : null;
  String? _extenderListValidator(_) =>
      _extenderIds.isEmpty ? 'At least one Extender Id is required' : null;

  // ---- Strictly separate scanners ----
  Future<void> _scanAndAddDevice(FormFieldState<void>? validatorState) async {
    final code = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QrScanPage(title: 'Scan Device QR')),
    );
    if (code == null || code.trim().isEmpty) return;

    setState(() {
      if (!_deviceIds.contains(code)) {
        _deviceIds.add(code);
      }
      _devIdDisplayCtrl.text = code; // show last scanned
      validatorState?.validate();
    });
  }

  Future<void> _scanAndAddExtender(FormFieldState<void>? validatorState) async {
    final code = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QrScanPage(title: 'Scan Extender QR')),
    );
    if (code == null || code.trim().isEmpty) return;

    setState(() {
      if (!_extenderIds.contains(code)) {
        _extenderIds.add(code);
      }
      _extIdDisplayCtrl.text = code; // show last scanned
      validatorState?.validate();
    });
  }

  // ---- SAVE to SharedPreferences on Login ----
  Future<void> _saveAllToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Save simple fields
    await prefs.setString(_kUserName,  _userCtrl.text.trim());
    await prefs.setString(_kPassword,  _passCtrl.text);           // ⚠️ Plaintext (see note below)
    await prefs.setString(_kEmail,     _emailCtrl.text.trim());
    await prefs.setString(_kStoreName, _storeCtrl.text.trim());
    await prefs.setString(_kTankModel, _tankCtrl.text.trim());

    // Save lists (device ids & extender ids)
    // Ensure no empties / trim & unique
    final uniqueDevices  = _deviceIds.map((e) => e.trim()).where((e) => e.isNotEmpty).toSet().toList();
    final uniqueExtenders= _extenderIds.map((e) => e.trim()).where((e) => e.isNotEmpty).toSet().toList();

    await prefs.setStringList(_kDeviceIds,   uniqueDevices);
    await prefs.setStringList(_kExtenderIds, uniqueExtenders);

    // Useful flags/metadata
    await prefs.setBool(_kLoggedIn, true);
    await prefs.setString(_kLastLoginAt, DateTime.now().toIso8601String());
  }

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
                top: headerImgH * 0.8,    // push below top curve
                bottom: bottomImgH * 0.9, // stop above bottom waves
              ),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          _box(TextFormField(
                            controller: _userCtrl,
                            textInputAction: TextInputAction.next,
                            decoration: _fxDecoration.copyWith(hintText: "Enter User Name"),
                            validator: (v) => _required(v, 'User Name'),
                          )),

                          // === Password ===
                          const SizedBox(height: _gapTop),
                          _label("Password"),
                          _box(TextFormField(
                            controller: _passCtrl,
                            textInputAction: TextInputAction.next,
                            obscureText: _obscure,
                            decoration: _fxDecoration.copyWith(
                              hintText: "•••• ••••",
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obscure = !_obscure),
                                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                              ),
                            ),
                            validator: _passwordVal,
                          )),

                          // === Email ===
                          const SizedBox(height: _gapTop),
                          _label("Email"),
                          _box(TextFormField(
                            controller: _emailCtrl,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _fxDecoration.copyWith(hintText: "Enter"),
                            validator: _emailVal,
                          )),

                          // === Store Name ===
                          const SizedBox(height: _gapTop),
                          _label("Store Name"),
                          _box(TextFormField(
                            controller: _storeCtrl,
                            textInputAction: TextInputAction.next,
                            decoration: _fxDecoration.copyWith(hintText: "Enter Store Name"),
                            validator: (v) => _required(v, 'Store Name'),
                          )),

                          // === Water Tank Model ===
                          const SizedBox(height: _gapTop),
                          _label("Water Tank Model"),
                          _box(TextFormField(
                            controller: _tankCtrl,
                            textInputAction: TextInputAction.next,
                            decoration: _fxDecoration.copyWith(hintText: "Enter Tank Model"),
                            validator: (v) => _required(v, 'Water Tank Model'),
                          )),

                          // === Device Id (scanner only, multi) ===
                          const SizedBox(height: _gapTop),
                          _label("Device Id"),
                          _box(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormField<void>(
                                  validator: _deviceListValidator,
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _devIdDisplayCtrl,
                                          readOnly: true,
                                          decoration: _fxDecoration.copyWith(
                                            hintText: "Scan QR Code",
                                            suffixIcon: IconButton(
                                              tooltip: 'Scan Device Id',
                                              onPressed: () => _scanAndAddDevice(state),
                                              icon: const Icon(Icons.qr_code_scanner_outlined),
                                            ),
                                          ),
                                        ),
                                        if (_deviceIds.isNotEmpty) ...[
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: _deviceIds.map((id) {
                                              return Chip(
                                                label: Text(id),
                                                onDeleted: () {
                                                  setState(() {
                                                    _deviceIds.remove(id);
                                                    _devIdDisplayCtrl.text =
                                                    _deviceIds.isNotEmpty ? _deviceIds.last : '';
                                                    state.validate();
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                        if (state.hasError)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                height: 1.0,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => _scanAndAddDevice(null),
                                    child: const Text("Add Device", style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // === Extender Id (scanner only, multi) ===
                          const SizedBox(height: _gapTop),
                          _label("Extender Id"),
                          _box(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormField<void>(
                                  validator: _extenderListValidator,
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _extIdDisplayCtrl,
                                          readOnly: true,
                                          decoration: _fxDecoration.copyWith(
                                            hintText: "Scan QR Code",
                                            suffixIcon: IconButton(
                                              tooltip: 'Scan Extender Id',
                                              onPressed: () => _scanAndAddExtender(state),
                                              icon: const Icon(Icons.qr_code_scanner_outlined),
                                            ),
                                          ),
                                        ),
                                        if (_extenderIds.isNotEmpty) ...[
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: _extenderIds.map((id) {
                                              return Chip(
                                                label: Text(id),
                                                onDeleted: () {
                                                  setState(() {
                                                    _extenderIds.remove(id);
                                                    _extIdDisplayCtrl.text =
                                                    _extenderIds.isNotEmpty ? _extenderIds.last : '';
                                                    state.validate();
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                        if (state.hasError)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                height: 1.0,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => _scanAndAddExtender(null),
                                    child: const Text("Add Extender", style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                              ],
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
                              onPressed: ()
                              async {


                                final ok = _formKey.currentState!.validate();
                                if (!ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill the required fields')),
                                  );
                                  return;
                                }

                                // Save EVERYTHING to SharedPreferences
                                await _saveAllToPrefs();

                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                                );
                              },
                              child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
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

  // Constrain width only; let height grow so error text never shrinks the field
  Widget _box(Widget child) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _fieldW),
      child: child,
    );
  }
}
