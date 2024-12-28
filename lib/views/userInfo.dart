import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/logout/logout_bloc.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/logout/logout_state.dart';
import 'package:login_registration_userinfo_bloc_firebase/views/loginScreen.dart';
import '../bloc/logout/logout_event.dart';
import '../storage_service/storage_service.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = StorageService.getUid();
    final userInfo = StorageService.getUserInfo();
    final GetStorage storage = GetStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        actions: [
          BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  // Clear storage before logging out
                  //StorageService.clearStorage();
                  // Trigger the logout event
                  context.read<LogoutBloc>().add(Logout());

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen(),),
                  );
                },
                icon:  Icon(Icons.logout),
              );
            },
          ),
        ],
        // actions: [
        //   BlocBuilder<LogoutBloc, LogoutState>(
        //     builder: (context, state) {
        //       return IconButton(
        //         onPressed: () {
        //           //StorageService.clearStorage();
        //
        //           context.read<LogoutBloc>().add(Logout());
        //
        //           // Navigator.pop(context);
        //           // storage.remove('isLoggedIn');
        //           //
        //           // Navigator.pushReplacement(
        //           //   context,
        //           //   MaterialPageRoute(builder: (context) => const LoginScreen()),
        //           // );
        //         },
        //         icon: const Icon(Icons.logout),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: userInfo != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: ${userInfo['name']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Phone: ${userInfo['phone']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Age: ${userInfo['age']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'UserType: ${userInfo['dropDown']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )
            : const Text(
                'No user information available',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
