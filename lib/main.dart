import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/logout/logout_bloc.dart';
import 'package:login_registration_userinfo_bloc_firebase/views/loginScreen.dart';
import 'package:login_registration_userinfo_bloc_firebase/views/splashScreen.dart';
import 'package:login_registration_userinfo_bloc_firebase/views/userInfo.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/registration/registration_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final GetStorage storage = GetStorage();
    // final bool isLoggedIn = storage.read('isLoggedIn') ?? false;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegistrationBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        // home: isLoggedIn ? UserInfoScreen() : LoginScreen(),

        //home: AuthScreen(),

        //home: RegistrationScreen(),

        //home: SplashScreen(),

        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return UserInfoScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
