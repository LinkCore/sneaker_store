import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sneaker_store/core/user/user.dart';
import 'package:hive/hive.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();

  factory UserRepository() {
    return _userRepository;
  }

  UserRepository._internal();

  late User currentUser;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserLocal(User user) async {
    var userBox = await Hive.openBox('userBox');
    userBox.put('user', user);
    currentUser = user;
  }

  Future<bool> isUserExistLocal() async {
    var userBox = await Hive.openBox('userBox');
    if (userBox.containsKey('user')) {
      currentUser = await userBox.get('user');
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeUserLocal() async {
    var userBox = await Hive.openBox('userBox');
    await userBox.clear();
  }

  Future<void> addUserRemote(User user) async {
    await _userCollection.doc(user.id).set(user.toJson());
    currentUser = user;
  }

  Future<bool> isUserExistRemote(String login, String password) async {
    QuerySnapshot collection = await _userCollection.get();
    for (var document in collection.docs) {
      User user = User.fromJson(
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
