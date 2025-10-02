import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/models/qr_model.dart';
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

// Future<void> saveContact(BuildContext context, {required String data}) async {
//   final line = data.split('\n');
//   String? name, phone, email;
//   for (var item in line) {
//     if (item.startsWith("FN:")) name = item.substring(3);
//     if (item.startsWith("TEL:")) name = item.substring(4);
//     if (item.startsWith("EMAIL:")) name = item.substring(5);
//   }
//   final contact =
//       contacts.Contact()
//         ...first = name ?? ''
//         ..phones = [contacts.Phone(phone ?? '')]
//         ..emails = [contacts.Email(email ?? '')];

//   try {
//     await contact.insert();

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Contact saved')));
//   } catch (e) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Faild')));
//   }
// }

Future<void> processScanedData(
  String? data, {
  required MobileScannerController controller,
 required BuildContext context,
}) async {
  if (data == null) return;
  controller.stop();
  String type = "Text";
  if (data.startsWith('http://') || data.startsWith('https://')) {
    type = "Url";
  } else if (data.startsWith('BEGIN:VCARD')) {
    type = "Contact";
  }
  customShowModelBottomSheet(context, type, data, controller);
}

saveQrCode(String data) async {
  final box = Hive.box<QrModel>('qrCodes');
  final qrModel = QrModel(data: data, createdAt: DateTime.now());
  await box.add(qrModel);
}

deleteQrCode(int index) async {
  final box = Hive.box<QrModel>('qrCodes');
  await box.deleteAt(index);
}
deleteAllQrCodes() async {
  final box = Hive.box<QrModel>('qrCodes');
  await box.clear();
}

Future<List<QrModel>> getAllQrCodes() async {
  final box = Hive.box<QrModel>('qrCodes');
  return box.values.toList();
}