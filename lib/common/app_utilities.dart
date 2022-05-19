import '../core/user/roles.dart';

class AppUtilities {
  static const Map<Roles, String> rolesEnumToString = {
    Roles.seller: "Seller",
    Roles.buyer: "Buyer",
  };

  static const Map<String, Roles> stringToRolesEnum = {
    "Seller": Roles.seller,
    "Buyer": Roles.buyer,
  };
}