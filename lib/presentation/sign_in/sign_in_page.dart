/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_indonesia_2021/application/auth/cubit/auth_cubit.dart';
import 'package:flutter_indonesia_2021/domain/auth/model/login_request.dart';
import 'package:flutter_indonesia_2021/presentation/home/home_page.dart';
// import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
// import 'package:flutter_ui_challenges/src/widgets/network_image.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // static final String path = "lib/src/pages/login/login1.dart";
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              print("auth error " + state.errorMessage);
            } else if (state is AuthLoading) {
              print("loading...");
            } else if (state is AuthLoginSuccess) {
              print("auth succed " + state.dataLogin.toJson().toString());
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey.shade800,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      // Container(width: 200, child: PNetworkImage(rocket),),
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                        title: TextField(
                          controller: emailTextEditingController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email address:",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Colors.white30,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      ListTile(
                        title: TextField(
                          controller: passwordTextEditingController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Password:",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white30,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: (state is AuthLoading)
                                ? _loginButtonLoading()
                                : _loginButton(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.grey.shade500),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  RaisedButton _loginButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        context.read<AuthCubit>().signUser(
              LoginRequest(
                // email: emailTextEditingController.text,
                // password: passwordTextEditingController.text,
                email: 'eve.holt@reqres.in',
                password: 'cityslicka',
              ),
            );
      },
      color: Colors.cyan,
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white70, fontSize: 16.0),
      ),
    );
  }

  RaisedButton _loginButtonLoading() {
    return RaisedButton(
      onPressed: null,
      color: Colors.cyan,
      child: CircularProgressIndicator(),
    );
  }
}
