import 'package:hive/hive.dart';

@HiveType(typeId: 0)
enum Roles {
@HiveField(0)
seller,
@HiveField(1)
buyer
}