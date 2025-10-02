import 'package:flutter/material.dart';
import 'package:qrcode/widgets/qr_code_generator.dart';
import 'package:qrcode/widgets/select_button_widget.dart';
import 'package:screenshot/screenshot.dart';

class GenerateQrViewBody extends StatelessWidget {
  const GenerateQrViewBody({
    super.key,
    required this.selectedType,
    required this.onSelectionChanged,
    required this.buildTextFiled,
    required this.qrData,
    required this.controller,
    this.onPressed,
   required this.onSaved,
  });

  final String selectedType;
  final void Function(Set<String>) onSelectionChanged;
  final Widget buildTextFiled;
  final String qrData;
  final ScreenshotController controller;
  final void Function()? onPressed;
  final void Function()? onSaved;
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    SelectButtonWidget(
                      selectedType: selectedType,
                      onSelectionChanged: onSelectionChanged,
                    ),
                    SizedBox(height: 24),
                    buildTextFiled,
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            if (qrData.isNotEmpty)
              QrCodeGenerator(
                controller: controller,
                qrData: qrData,
                onPressed: onPressed,
                onSaved: onSaved,
              ),
            SizedBox(height: keyboardHeight),
          ],
        ),
      ),
    );
  }
}
