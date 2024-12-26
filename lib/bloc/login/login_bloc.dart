import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

import 'login_event.dart';
import 'login_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage _storage = GetStorage();

  SignInBloc() : super(SignInInitial()) {
    on<PerformSignIn>((event, emit) async {
      emit(SignInLoading());
      try {
        final UserCredential user = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        _storage.write('isLoggedIn', true);
        _storage.write('uid', user.user?.uid);
        emit(SignInSuccess('Sign-in successful'));
      } catch (e) {
        emit(SignInFailure(e.toString()));
      }
    });
  }
}
