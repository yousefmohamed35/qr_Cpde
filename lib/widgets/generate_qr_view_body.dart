import 'package:flutter/material.dart';
import 'package:qrcode/widgets/select_button_widget.dart';

class GenerateQrViewBody extends StatelessWidget {
  const GenerateQrViewBody({
    super.key,
    required this.selectedType,
    required this.onSelectionChanged,
    required this.buildTextFiled,
  });

  final String selectedType;
  final void Function(Set<String>) onSelectionChanged;
  final Widget buildTextFiled;
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
