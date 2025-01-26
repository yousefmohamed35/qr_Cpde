import 'package:flutter/material.dart';
import 'package:qrcode/widgets/custom_container.dart';
import 'package:qrcode/widgets/title_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              TitleWidget(),
              SizedBox(height: 50),
              CustomContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
