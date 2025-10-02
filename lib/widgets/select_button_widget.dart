import 'package:flutter/material.dart';

class SelectButtonWidget extends StatelessWidget {
  const SelectButtonWidget({
    super.key,
    required this.selectedType,
    required this.onSelectionChanged,
  });

  final String selectedType;
  final void Function(Set<String>) onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(
          value: 'Text',
          label: Text("Text"),
          icon: Icon(Icons.text_fields),
        ),
        ButtonSegment(value: 'Url', label: Text("Url"), icon: Icon(Icons.link)),
      ],
      selected: {selectedType},
      onSelectionChanged: onSelectionChanged,
    );
  }
}
