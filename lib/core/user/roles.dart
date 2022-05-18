import 'package:hive/hive.dart';

@HiveType(typeId: 0)
enum Roles {
@HiveField(0)
admin,
@HiveField(1)
user
}