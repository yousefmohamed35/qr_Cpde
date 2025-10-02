import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrcode/all_qr_codes.dart';
import 'package:qrcode/generate_exist_qr.dart';
import 'package:qrcode/widgets/custom_container.dart';
import 'package:qrcode/widgets/title_widget.dart';

import 'models/qr_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<QrModel>('qrCodes');
    final qrCodes = box.values.toList();
    log('QR Codes: ${qrCodes.length}');

    // نعرض أول 5 عناصر فقط في الـ Drawer
    final int limit = 2;
    final int itemsToShow = qrCodes.length > limit ? limit : qrCodes.length;

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: qrCodes.isEmpty
            ? const Center(
                child: Text(
                  'No QR codes saved',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : Column(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    child: Center(
                      child: Text(
                        'Your last QR Codes',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: itemsToShow,
                      itemBuilder: (context, index) {
                        final qr = qrCodes[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      GenerateExistQr(data: qr.data),
                                ),
                              );
                            },
                            title: Text(qr.data),
                            subtitle: Text(qr.createdAt.toString()),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await qr.delete();
                                (context as Element).markNeedsBuild();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Visibility(
                    visible: qrCodes.length > limit,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllQrCodes(qrCodes: qrCodes),
                            ),
                          );
                        },
                        child: const Text('See All'),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: const [
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

class AllQrCodesPage extends StatelessWidget {
  final List<QrModel> qrCodes;
  const AllQrCodesPage({super.key, required this.qrCodes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All QR Codes')),
      body: ListView.builder(
        itemCount: qrCodes.length,
        itemBuilder: (context, index) {
          final qr = qrCodes[index];
          return Card(
            child: ListTile(
              title: Text(qr.data),
              subtitle: Text(qr.createdAt.toString()),
            ),
          );
        },
      ),
    );
  }
}
