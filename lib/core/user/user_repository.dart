import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sneaker_store/core/user/roles.dart';
import 'package:flutter_sneaker_store/core/user/user.dart';
import 'package:hive/hive.dart';

import '../../common/app_constance.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();

  factory UserRepository() {
    return _userRepository;
  }

  UserRepository._internal();

  late LocalUser currentUser;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection(AppConstance.users);

  Future<void> addUserLocal(
      String? login, String? password, Roles? roles, String? id) async {
    var userBox = await Hive.openBox(AppConstance.userBox);
    userBox.put(AppConstance.login, login);
    userBox.put(AppConstance.password, password);
    userBox.put(AppConstance.roles, roles!.index);
    userBox.put(AppConstance.id, id);

    currentUser =
        LocalUser(id: id, roles: roles, login: login, password: password);
  }

  Future<bool> isUserExistLocal() async {
    var userBox = await Hive.openBox(AppConstance.userBox);
    if (userBox.containsKey(AppConstance.id) &&
        userBox.containsKey(AppConstance.roles) &&
        userBox.containsKey(AppConstance.login) &&
        userBox.containsKey(AppConstance.password)) { await addUserLocal(
          userBox.get(AppConstance.login),
          userBox.get(AppConstance.password),
          Roles.values[userBox.get(AppConstance.roles)],
          userBox.get(AppConstance.id));
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeUserLocal() async {
    var userBox = await Hive.openBox(AppConstance.userBox);
    await userBox.clear();
  }

  Future<void> addUserRemote(LocalUser user) async {
    await _userCollection.doc(user.id).set(user.toJson());
    currentUser = user;
  }

  Future<bool> isUserExistRemote(String login, String password) async {
    QuerySnapshot collection = await _userCollection.get();
    for (var document in collection.docs) {
      LocalUser user = LocalUser.fromJson(
          json: document.data() as Map<String, dynamic>, id: document.id);
      if (user.login == login) {
        if (user.password == password) {
          currentUser = user;
          return true;
        }
      }
    }
    return false;
  }
}