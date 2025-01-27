import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode/functions/data.dart';
import 'package:qrcode/widgets/generate_qr_view_body.dart';
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
      case 'Contact':
        return '''BEGIN:VCARD
        VERSION:3.0
        FN: ${_controllers['name']?.text}
        TEL: ${_controllers['phone']?.text}
        EMAIL: ${_controllers['email']?.text}
        END:VCARD''';
      case 'Url':
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: buildAppBar(title: 'Generate QR Code'),
        body: GenerateQrViewBody(
          selectedType: selectedType,
          onSelectionChanged: (Set<String> selection) {
            setState(() {
              selectedType = selection.first;
              log(qrData);
              qrData = '';
            });
          },
          buildTextFiled: buildInputField(),
          qrData: qrData,
          controller: _screenshotController,
          onPressed: () => shareQRcode(),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onChanged: (_) {
          setState(() {});
          qrData = generateQRData();
        },
      ),
    );
  }

  Widget buildInputField() {
    switch (selectedType) {
      case 'Contact':
        return Column(
          children: [
            buildTextField(_controllers['name']!, 'Name'),
            buildTextField(_controllers['phone']!, 'Phone'),
            buildTextField(_controllers['email']!, 'Email'),
          ],
        );
      case 'Url':
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
