import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart' as contacts;
import 'package:flutter_contacts/properties/email.dart' as contacts;
import 'package:flutter_contacts/properties/phone.dart' as contacts;

import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/widgets/show_model_sheet_widget.dart';
import 'package:url_launcher/url_launcher.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    elevation: 0,
    title: Text(title, style: GoogleFonts.poppins()),
  );
}

Future<dynamic> customShowModelBottomSheet(
  BuildContext context,
  String type,
  String scannedData,
  MobileScannerController mobileScannerController,
) {
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
              (context, scrollController) => ShowModelSheetWidget(
                type: type,
                scrollController: scrollController,
                scannedData: scannedData,
                mobileScannerController: mobileScannerController,
              ),
        ),
  );
}

Future<void> openUrl({required String url}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch the URL';
  }
}

Future<void> saveContact(BuildContext context, {required String data}) async {
  final line = data.split('\n');
  String? name, phone, email;
  for (var item in line) {
    if (item.startsWith("FN:")) name = item.substring(3);
    if (item.startsWith("TEL:")) name = item.substring(4);
    if (item.startsWith("EMAIL:")) name = item.substring(5);
  }
  final contact =
      contacts.Contact()
        ..name.first = name ?? ''
        ..phones = [contacts.Phone(phone ?? '')]
        ..emails = [contacts.Email(email ?? '')];

  try {
    await contact.insert();
   
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Contact saved')));
  } catch (e) {
   
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Faild')));
  }
}
