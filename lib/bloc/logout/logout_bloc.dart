import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/logout/logout_event.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/logout/logout_state.dart';

import '../../helper/auth_helper.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(AppStateLoggedOut(isLoading: false, successful: false)) {
    on<Logout>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await AuthHelper().signOut();
        emit(AppStateLoggedOut(isLoading: false, successful: true));
      } catch (e) {
        e.toString();
      }
    });
  }
}
