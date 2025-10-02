import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateExistQr extends StatelessWidget {
  const GenerateExistQr({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Qr Code')),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Container(
          color: Colors.white,
          child: QrImageView(
            data: data,
            size: 200,
            version: QrVersions.auto,
            errorCorrectionLevel: QrErrorCorrectLevel.H,
          ),
        ),
      ),
    );
  }
}
