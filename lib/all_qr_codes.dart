import 'package:flutter/material.dart';
import 'package:qrcode/generate_exist_qr.dart';
import 'package:qrcode/home_view.dart';
import 'models/qr_model.dart';

class AllQrCodes extends StatefulWidget {
  const AllQrCodes({super.key, required this.qrCodes});
  final List<QrModel> qrCodes;

  @override
  State<AllQrCodes> createState() => _AllQrCodesState();
}

class _AllQrCodesState extends State<AllQrCodes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All QR Codes'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeView()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.qrCodes.length,
          itemBuilder: (context, index) {
            final qr = widget.qrCodes[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.qr_code),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GenerateExistQr(data: qr.data),
                    ),
                  );
                },
                title: Text(qr.data),
                subtitle: Text(qr.createdAt.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await qr.delete();
                    setState(() {
                      widget.qrCodes.remove(qr);
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
