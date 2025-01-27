import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrcode/show_model_sheet_widget.dart';


AppBar buildAppBar({required String title}) {
  return AppBar(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    elevation: 0,
    title: Text(title, style: GoogleFonts.poppins()),
  );
}

Future<dynamic> customShowModelBottomSheet(BuildContext context,String type) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder:
              (context, scrollController) => ShowModelSheetWidget(type: type,),
        ),
  );
}

