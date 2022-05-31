import 'package:flutter_sneaker_store/core/user/roles.dart';
import 'package:flutter_sneaker_store/core/user/user_keys.dart';
import '../../common/app_utilities.dart';

class LocalUser {
  LocalUser({
    String? id,
    Roles? roles,
    String? login,
    String? password
  }) {
    _id = id;
    _roles = roles;
    _login = login;
    _password = password;
  }

  LocalUser.fromJson({required Map<String, dynamic> json, required String id}) {
    _id = id;
    _roles = AppUtilities.stringToRolesEnum[json [UserKeys.roles]];
    _login = json[UserKeys.login];
    _password = json[UserKeys.password];
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
    userMap[UserKeys.roles] = AppUtilities.rolesEnumToString[_roles];
    userMap[UserKeys.login] = login;
    userMap[UserKeys.password] = password;
    return userMap;
  }
}
