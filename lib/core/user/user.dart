import 'package:flutter_sneaker_store/core/user/roles.dart';
import 'package:hive/hive.dart';

import '../../common/app_utilities.dart';

@HiveType(typeId: 0)
class LocalUser {
  LocalUser({
    @HiveField(0)
    String? id,
    @HiveField(1)
    Roles? roles,
    @HiveField(2)
    String? login,
    @HiveField(3)
    String? password,
  }) {
    _id = id;
    _roles = roles;
    _login = login;
    _password = password;
  }

  LocalUser.fromJson({required Map<String, dynamic> json, required String id}) {
    _id = id;
    _roles = AppUtilities.stringToRolesEnum[json ['roles']];
    _login = json['login'];
    _password = json['password'];
  }

  String? _id;
  Roles? _roles;
  String? _login;
  String? _password;

  String? get id => _id;

  Roles? get roles => _roles;

  String? get login => _login;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final userMap = <String, dynamic>{};
    userMap['roles'] = AppUtilities.rolesEnumToString[_roles];
    userMap['login'] = login;
    userMap['password'] = password;
    return userMap;
  }
}
