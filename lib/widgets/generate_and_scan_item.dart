import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenerateAndScanItem extends StatelessWidget {
  const GenerateAndScanItem({
    super.key,
    required this.onTap,
    required this.icon, required this.title,
  });
  final void Function() onTap;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        height: 200,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Icon(icon, size: 90, color: Colors.white),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
