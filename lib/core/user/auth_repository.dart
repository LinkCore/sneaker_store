// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';

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
     throw Exception('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
     throw Exception('The account already exists for that email.');
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
      throw Exception('No user found for that email.');
     } else if (e.code == 'wrong-password') {
      throw Exception('Wrong password provided for that user.');
     }
    }
   }
  }


//     try{
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       _userCollection =
//           FirebaseFirestore.instance.collection('users');
//     } on Exception catch (e) {
//
//     }
//   }
// }


//   final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
//
//   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//   if (user == null) {
//   print('User is currently signed out!');
//   } else {
//   print('User is signed in!');
//   }
//   }) {
//   // TODO: implement listen
//   throw UnimplementedError();
// }
//  }
//
//   final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
//
//   factory AuthRepository() {
//     return _firebaseAuth;
//   }
//
//   late final CollectionReference _userCollection;
//
//   Future<void> _signInWithEmail(String email, String password) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on Exception catch (e) {
//       // TODO
//     }
//   }
//
//   Future<void> signUpWithEmail(String email, String password) async {
//
//     try{
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       _userCollection =
//           FirebaseFirestore.instance.collection('users');
//     } on Exception catch (e) {
//
//     }
//   }
// }