import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_indonesia_2021/application/auth/cubit/auth_cubit.dart';
import 'package:flutter_indonesia_2021/presentation/sign_in/sign_in_page.dart';
import 'package:flutter_indonesia_2021/presentation/user/user_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..loadUserFromLocal(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            print('data user : ${state.dataLogin}');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                // builder: (context) => HomePage(),
                builder: (context) => UserPage(),
              ),
            );
          } else if (state is AuthError) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInPage(),
              ),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
