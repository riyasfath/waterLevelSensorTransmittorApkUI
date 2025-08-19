import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key, this.title});
  final String? title;

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final MobileScannerController _controller = MobileScannerController(
    torchEnabled: false,
    detectionSpeed: DetectionSpeed.noDuplicates, // avoid duplicate callbacks
    formats: const [BarcodeFormat.qrCode],      // QR only (add more if needed)
  );

  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_handled) return;
    final raw = capture.barcodes
        .map((b) => b.rawValue)
        .firstWhere((v) => v != null && v.isNotEmpty, orElse: () => null);

    if (raw != null && raw.isNotEmpty) {
      _handled = true;
      await _controller.stop();
      if (!mounted) return;
      Navigator.pop(context, raw); // return scanned string
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Toggle torch',
                    icon: const Icon(Icons.flash_on, color: Colors.white),
                    onPressed: () => _controller.toggleTorch(),
                  ),
                  IconButton(
                    tooltip: 'Switch camera',
                    icon: const Icon(Icons.cameraswitch, color: Colors.white),
                    onPressed: () => _controller.switchCamera(),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: CustomPaint(
              painter: _ScanWindowPainter(),
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Text(
              widget.title ?? 'Align QR within the frame',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dimmed overlay with rounded square “scan window” and corner guides.
class _ScanWindowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final overlay = Paint()..color = Colors.black.withOpacity(0.55);

    final double windowSize = size.width * 0.70;
    final Rect window = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: windowSize,
      height: windowSize,
    );

    final Path bg = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final RRect rrect = RRect.fromRectAndRadius(window, const Radius.circular(18));
    final Path hole = Path()..addRRect(rrect);
    final Path overlayPath = Path.combine(PathOperation.difference, bg, hole);
    canvas.drawPath(overlayPath, overlay);

    final Paint corner = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    const double edge = 28;
    // top-left
    canvas.drawLine(window.topLeft, window.topLeft + const Offset(edge, 0), corner);
    canvas.drawLine(window.topLeft, window.topLeft + const Offset(0, edge), corner);
    // top-right
    canvas.drawLine(window.topRight, window.topRight + const Offset(-edge, 0), corner);
    canvas.drawLine(window.topRight, window.topRight + const Offset(0, edge), corner);
    // bottom-left
    canvas.drawLine(window.bottomLeft, window.bottomLeft + const Offset(edge, 0), corner);
    canvas.drawLine(window.bottomLeft, window.bottomLeft + const Offset(0, -edge), corner);
    // bottom-right
    canvas.drawLine(window.bottomRight, window.bottomRight + const Offset(-edge, 0), corner);
    canvas.drawLine(window.bottomRight, window.bottomRight + const Offset(0, -edge), corner);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
