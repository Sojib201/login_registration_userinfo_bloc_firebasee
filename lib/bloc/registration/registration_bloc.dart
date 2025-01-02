import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/registration/registration_event.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/registration/registration_state.dart';

import '../../helper/auth_helper.dart';
import '../../storage_service/storage_service.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final List<String> dropdownlist = ['Supervisor', 'Representitive', 'ZM'];
  String? selectedItem;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthHelper helper = AuthHelper();
  final GetStorage _storage = GetStorage();

  RegistrationBloc() : super(SignUpInitial()) {
    on<LoadDropDownList>((event, emit) {
      emit(DropDownLoadedState(dropdownlist, selectedItem));
    });

    on<DropdownItemSelected>((event, emit) {
      selectedItem = event.itemSelect;

      emit(DropDownLoadedState(dropdownlist, selectedItem));
    });

    on<PerformRegistration>((event, emit) async {
      emit(SignUpLoading());
      try {
        await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        // _storage.write('isLoggedIn', true);
        // _storage.write('uid', user.user?.uid);
        StorageService.saveUserInfo({
          'name': event.name,
          'phone': event.phone,
          'age': event.age,
          'dropDown': event.userType
        });
        emit(SignUpSuccess('Sign-up successful'));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(SignUpFailure('The password provided is too weak,'));
          print('The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          emit(SignUpFailure('The account already exists for that email'));
          print('The account already exists for that email');
        }
        emit(DropDownLoadedState(dropdownlist, selectedItem));
      } catch (e) {
        //emit(SignUpFailure());
        //emit(DropDownLoadedState(item, selectedItem));
      }
    });
  }
}
