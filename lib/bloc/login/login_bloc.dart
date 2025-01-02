// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:login_registration_userinfo_bloc_firebase/bloc/registration/registration_state.dart';
// import 'package:login_registration_userinfo_bloc_firebase/helper/auth_helper.dart';
//
// import 'login_event.dart';
// import 'login_state.dart';
//
// class SignInBloc extends Bloc<SignInEvent, SignInState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final AuthHelper helper = AuthHelper();
//   final GetStorage _storage = GetStorage();
//
//   SignInBloc() : super(SignInInitial()) {
//     on<PerformSignIn>(
//       (event, emit) async {
//         emit(SignInLoading());
//         try {
//           await helper.SignIn(
//             email: event.email,
//             password: event.password,
//           );
//
//           //_storage.write('isLoggedIn', true);
//           //_storage.write('uid', user.user?.uid);
//           if (_auth.currentUser!.uid.isNotEmpty) {
//             emit(
//               SignInSuccess('Sign-in successful'),
//             );
//           } else {}
//         } catch (e) {
//           emit(
//             SignInFailure('Sign-in Failed'),
//           );
//         }
//       },
//     );
//   }
//
//   // SignInBloc() : super(SignInInitial()) {
//   //   on<PerformSignIn>(
//   //     (event, emit) async {
//   //       emit(SignInLoading());
//   //       try {
//   //         final UserCredential user = await _auth.signInWithEmailAndPassword(
//   //           email: event.email,
//   //           password: event.password,
//   //         );
//   //         _storage.write('isLoggedIn', true);
//   //         _storage.write('uid', user.user?.uid);
//   //         emit(SignInSuccess('Sign-in successful'));
//   //       } catch (e) {
//   //         emit(SignInFailure(e.toString()));
//   //       }
//   //     },
//   //   );
//   // }
// }

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_registration_userinfo_bloc_firebase/helper/auth_helper.dart';

import 'login_event.dart';
import 'login_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthHelper helper = AuthHelper();

  SignInBloc()
      : super(
          SignInInitial(),
        ) {
    on<PerformSignIn>(
      (event, emit) async {
        emit(
          SignInLoading(),
        );

        if (event.email.isEmpty || event.password.isEmpty) {
          emit(SignInFailure('Email and password cannot be empty.'));
          return;
        }

        final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
        if (!emailRegex.hasMatch(event.email)) {
          emit(
            SignInFailure('Please enter a valid email address.'),
          );
          return;
        }

        if (event.password.length < 6) {
          emit(
            SignInFailure('Password must be at least 6 characters long.'),
          );
          return;
        }

        try {
          await helper.SignIn(
            email: event.email,
            password: event.password,
          );

          if (_auth.currentUser?.uid != null &&
              _auth.currentUser!.uid.isNotEmpty) {
            //_storage.write('isLoggedIn', true);
            //_storage.write('uid', _auth.currentUser!.uid);

            emit(
              SignInSuccess('Sign-in Successful'),
            );
          } else {
            emit(
              SignInFailure('Wrong email or password'),
            );
          }
        } catch (e) {
          emit(
            SignInFailure('An unexpected error occurred. Please try again.'),
          );
        }
      },
    );
  }
}
