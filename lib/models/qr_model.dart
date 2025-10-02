import 'package:hive/hive.dart';
part'qr_model.g.dart';
@HiveType(typeId: 0)
class QrModel extends HiveObject {
  @HiveField(0)
  final String data;
  @HiveField(1)
  final DateTime createdAt;

  QrModel({required this.data, required this.createdAt});
}
