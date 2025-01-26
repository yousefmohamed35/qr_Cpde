import 'package:flutter/material.dart';
import 'package:qrcode/widgets/custom_container_child.dart';


class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              blurRadius: 10,
              color: Colors.black12.withOpacity(0.1),
            ),
          ],
        ),
        child: CustomContainerChild(),
      ),
    );
  }
}

