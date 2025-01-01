import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_userinfo_bloc_firebase/utils/style.dart';
import 'package:login_registration_userinfo_bloc_firebase/views/registrationScreen.dart';
import 'package:login_registration_userinfo_bloc_firebase/views/userInfo.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: AppInputDeceration("Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: AppInputDeceration("Password"),
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignInSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => UserInfoScreen(),
                  //   ),
                  // );
                } else if (state is SignInFailure) {
                  print(state.error);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is SignInLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      context.read<SignInBloc>().add(
                            PerformSignIn(email, password),
                          );
                    },
                    child: SuccessButtonChild("Sign In"),
                    style: AppButtonStyle(),
                  );
                }
              },
            ),
            const SizedBox(height: 15),

            // ElevatedButton(
            //   onPressed: () {
            //     final email = emailController.text;
            //     final password = passController.text;
            //     final AuthHelper obj = AuthHelper();
            //     obj.SignIn(email, password, context);
            //     print('login success');
            //   },
            //   child: SuccessButtonChild("Login"),
            //   style: AppButtonStyle(),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // BlocConsumer<SignInBloc, SignInState>(
            //   listener: (context, state) {
            //     if (state is SignInSuccess) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text(state.message)),
            //       );
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => UserInfoScreen(),
            //         ),
            //       );
            //     } else if (state is SignInFailure) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text(state.error)),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is SignInLoading) {
            //       return const CircularProgressIndicator();
            //     }
            //     return ElevatedButton(
            //       onPressed: () {
            //         final email = emailController.text.trim();
            //         final password = passwordController.text.trim();
            //         context
            //             .read<SignInBloc>()
            //             .add(PerformSignIn(email, password));
            //       },
            //       child: const Text('Sign In'),
            //     );
            //   },
            // ),
            // const SizedBox(height: 8),

            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have a account?",
                          style: HeadText7(colorDarkBlue),
                        ),
                        Text(
                          " Register",
                          style: HeadText7(Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
