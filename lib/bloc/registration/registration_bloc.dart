import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/registration/registration_event.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/registration/registration_state.dart';

import '../../helper/auth_helper.dart';
import '../../storage_service/storage_service.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final List<String> item = ['Supervisor', 'Representitive', 'ZM'];
  String? selectedItem;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthHelper helper = AuthHelper();
  final GetStorage _storage = GetStorage();

  RegistrationBloc() : super(SignUpInitial()) {
    on<LoadDropDownList>((event, emit) {
      emit(DropDownLoadedState(item, selectedItem));
    });

    on<DropdownItemSelected>((event, emit) {
      selectedItem = event.itemSelect;

      emit(DropDownLoadedState(item, selectedItem));
    });

    on<PerformRegistration>((event, emit) async {
      emit(SignUpLoading());
      try {
        final UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        //_storage.write('isLoggedIn', true);
        _storage.write('uid', user.user?.uid);
        StorageService.saveUserInfo({
          'name': event.name,
          'phone': event.phone,
          'age': event.age,
          'dropDown': event.userType
        });
        emit(SignUpSuccess('Sign-up successful'));
      } catch (e) {
        emit(SignUpFailure('Sign-up Failed'));
      }
    });
  }
}
