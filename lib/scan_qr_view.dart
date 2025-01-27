import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrcode/functions/data.dart';
import 'package:qrcode/widgets/not_has_permission.dart';

class ScanQrView extends StatefulWidget {
  const ScanQrView({super.key});

  @override
  State<ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  bool hasPermission = false;
  bool isFlashOn = false;
  String scannedData = '';
  late MobileScannerController _mobileScannerController;
  @override
  void initState() {
    super.initState();
    _mobileScannerController = MobileScannerController();
    checkPermission();
  }

  @override
  void dispose() {
    _mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return hasPermission
        ? 
        : NotHasPermission(
          onPressed: () {
            checkPermission();
          },
        );
  }

  Future<void> checkPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      hasPermission = status.isGranted;
    });
  }

  Future<void> processScanedData(String? data) async {
    if (data == null) return;
    _mobileScannerController.stop();
    String type = "Text";
    if (data.startsWith('http://') || data.startsWith('https://')) {
      type = "Url";
    } else if (data.startsWith('BEGIN:VCARD')) {
      type = "Contact";
    }
    customShowModelBottomSheet(
      context,
      type,
      scannedData,
      _mobileScannerController,
    );
  }
}
