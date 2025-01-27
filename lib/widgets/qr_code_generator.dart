import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrCodeGenerator extends StatelessWidget {
  const QrCodeGenerator({
    super.key,
    required this.controller,
    required this.qrData,
    required this.onPressed,
  });

  final ScreenshotController controller;
  final String qrData;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Screenshot(
              controller: controller,
              child: Container(
                color: Colors.white,
                child: QrImageView(
                  data: qrData,
                  size: 200,
                  version: QrVersions.auto,
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onPressed,
          label: Text('share QR code'),
          icon: Icon(Icons.share),
        ),
      ],
    );
  }
}
