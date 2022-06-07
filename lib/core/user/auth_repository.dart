import 'package:firebase_auth/firebase_auth.dart';

import '../../common/app_constants.dart';
import '../../generated/l10n.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();

  factory AuthRepository() {
    return _authRepository;
  }

  AuthRepository._internal();

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppConstants.weakPassword) {
        throw Exception(S.current.thePasswordProvidedIsTooWeak);
      } else if (e.code == AppConstants.emailAlreadyInUse) {
        throw Exception(S.current.theAccountAlreadyExistsForThatEmail);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppConstants.userNotFound) {
        throw Exception(S.current.noUserFoundForThatEmail);
      } else if (e.code == AppConstants.wrongPassword) {
        throw Exception(S.current.wrongPasswordProvidedForThatUser);
      }
    }
  }
}