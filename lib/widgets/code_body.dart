import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/functions/data.dart';
import 'package:share_plus/share_plus.dart';

class CodeBody extends StatelessWidget {
  const CodeBody({
    super.key,
    required this.scannedData,
    required this.type,
    required this.mobileScannerController,
  });

  final String scannedData;
  final String type;
  final MobileScannerController mobileScannerController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          scannedData,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 24),
        if (type == "Url")
          ElevatedButton.icon(
            onPressed: () {
              openUrl(url: scannedData);
            },
            label: Text("Open URL"),
            icon: Icon(Icons.open_in_new),
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
          ),
        if (type == "Contact")
          ElevatedButton.icon(
            onPressed: () {
              saveContact(context, data: scannedData);
            },
            label: Text("save contact"),
            icon: Icon(Icons.open_in_new),
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
          ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Share.share(scannedData);
                },
                label: Text("Share "),
                icon: Icon(Icons.share),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  mobileScannerController.start();
                },
                label: Text("Scan Again "),
                icon: Icon(Icons.qr_code_scanner),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
