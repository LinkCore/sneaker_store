import 'package:firebase_auth/firebase_auth.dart';

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
        .createUserWithEmailAndPassword(
     email: email,
     password: password,
    );
   } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
     throw Exception(S.current.thePasswordProvidedIsTooWeak);
    } else if (e.code == 'email-already-in-use') {
     throw Exception(S.current.theAccountAlreadyExistsForThatEmail);
    }
   } catch (e) {
    throw Exception(e);
   }
  }

   Future<void> signInWithEmail(String email, String password) async {
    try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password
     );
    } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
      throw Exception(S.current.noUserFoundForThatEmail);
     } else if (e.code == 'wrong-password') {
      throw Exception(S.current.wrongPasswordProvidedForThatUser);
     }
    }
   }
  }