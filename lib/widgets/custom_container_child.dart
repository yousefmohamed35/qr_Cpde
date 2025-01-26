import 'package:flutter/material.dart';
import 'package:qrcode/Generate_qr_view.dart';
import 'package:qrcode/scan_qr_view.dart';
import 'package:qrcode/widgets/generate_and_scan_item.dart';

class CustomContainerChild extends StatelessWidget {
  const CustomContainerChild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GenerateAndScanItem(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenerateQrView()),
              ),
          icon: Icons.qr_code,
          title: "Generate QR Code",
        ),
        SizedBox(height: 30),
        GenerateAndScanItem(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanQrView()),
              ),
          icon: Icons.qr_code_scanner,
          title: "Scan QR Code",
        ),
      ],
    );
  }
}
