import '../core/user/roles.dart';

class AppUtilities {
  static const Map<Roles, String> rolesEnumToString = {
    Roles.admin: "Admin",
    Roles.user: "User",
  };

  static const Map<String, Roles> stringToRolesEnum = {
    "Admin": Roles.admin,
    "User": Roles.user,
  };
}