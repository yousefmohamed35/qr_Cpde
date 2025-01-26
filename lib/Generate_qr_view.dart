import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQrView extends StatefulWidget {
  const GenerateQrView({super.key});

  @override
  State<GenerateQrView> createState() => _GenerateQrViewState();
}

class _GenerateQrViewState extends State<GenerateQrView> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  String qrData = '';
  String selectedType = '';
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'url': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
  };
  String generateQRData() {
    switch (selectedType) {
      case 'contact':
        return '''BEGIN:VCARD
        VERSION:3.0
        FN: ${_controllers['name']?.text}
        TEL: ${_controllers['phone']?.text}
        EMAIL: ${_controllers['email']?.text}
        END:VCARD''';
      case 'url':
        String url = _controllers['url']?.text ?? '';
        if (!url.startsWith('https://') && !url.startsWith('http://')) {
          url = 'https://$url';
        }
        return url;
      default:
        return _textEditingController.text;
    }
  }

  Future<void> shareQRcode() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/qr_code.png';
    final capture = await _screenshotController.capture();
    if (capture == null) {
      return;
    }
    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(capture);
    await Share.shareXFiles([XFile(imagePath)], text: "Share QR Code");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold());
  }

  TextField buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onChanged: (_) {
        setState(() {});
        qrData = generateQRData();
      },
    );
  }

  Widget buildInputField() {
    switch (selectedType) {
      case 'contact':
        return Column(
          children: [
            buildTextField(_controllers['name']!, 'Name'),
            buildTextField(_controllers['phone']!, 'Phone'),
            buildTextField(_controllers['email']!, 'Email'),
          ],
        );
      case 'url':
        return buildTextField(_controllers['url']!, 'URL');
      default:
        return TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            labelText: 'Enter Text',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onChanged: (value) {
            setState(() {});
            qrData = value;
          },
        );
    }
  }
}
