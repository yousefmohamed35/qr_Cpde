import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/widgets/code_body.dart';
import 'package:qrcode/widgets/custom_line.dart';

class ShowModelSheetWidget extends StatelessWidget {
  const ShowModelSheetWidget({
    super.key,
    required this.type,
    required this.scrollController,
    required this.scannedData, required this.mobileScannerController,
  });
  final String type;
  final ScrollController scrollController;
  final String scannedData;
  final MobileScannerController mobileScannerController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLine(),
          Text(
            "Scanner Result:",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          Text(
            "Type: ${type.toUpperCase()}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: CodeBody(scannedData: scannedData, type: type, mobileScannerController:mobileScannerController ,),
            ),
          ),
        ],
      ),
    );
  }
}

