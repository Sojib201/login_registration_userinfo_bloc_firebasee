import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:login_registration_userinfo_bloc_firebase/views/loginScreen.dart';

class AuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future Registration({
    required String email,
    required String password,
  }) async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // var authCredential = userCredential.user;
      // print(authCredential);
      // if (authCredential!.uid.isNotEmpty) {
      //   box.write('id', authCredential.uid);
      //
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => LoginScreen(),
      //     ),
      //   );
      // } else {
      //   print("sign up failed");
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> SignIn({
    required String email,
    required String password,
  }) async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // var authCredential = userCredential.user;
      // print(authCredential);
      // if (authCredential!.uid.isNotEmpty) {
      //   Navigator.push(
      //
      //   context,
      //     MaterialPageRoute(
      //       builder: (_) => UserInfoScreen(),
      //     ),
      //   );
      // } else {
      //   print("sign up failed");
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
