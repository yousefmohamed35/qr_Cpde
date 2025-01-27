import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrcode/functions/data.dart';

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
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: buildAppBar(title: 'Scan QR Code'),
      body:
          hasPermission
              ? Column()
              : NotHasPermission(),
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

