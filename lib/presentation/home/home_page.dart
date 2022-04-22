import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_indonesia_2021/application/profile/bloc/profileb_bloc.dart';
import 'package:flutter_indonesia_2021/domain/auth/model/login_response.dart';
import 'package:flutter_indonesia_2021/domain/core/user/model/user_response.dart';
import 'package:flutter_indonesia_2021/presentation/sign_in/sign_in_page.dart';
import 'package:flutter_indonesia_2021/utils/constants.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginResponse? _loginResponse;

  @override
  void initState() {
    final data = GetStorage().read(USER_LOCAL_KEY);
    _loginResponse = LoginResponse.fromJson(jsonDecode(data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilebBloc()..add(ProfilebEvent.getAllUser()),
      child: BlocConsumer<ProfilebBloc, ProfilebState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            isLoading: (value) {
              print('is loading');
            },
            isSuccess: (value) {
              print('is success, ${value.userResponse.toJson()}');
            },
          );
        },
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => HomePageLoading(),
            isLoading: (value) => HomePageLoading(),
            isSuccess: (value) => HomeScaffold(value.userResponse.data),
            isError: (value) => HomePageError(value.errMsg),
          );
        },
      ),
    );
  }

  Scaffold HomePageError(String? errMsg) => Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Something Wrong!'),
              IconButton(
                onPressed: () {
                  context.read<ProfilebBloc>().add(ProfilebEvent.getAllUser());
                },
                icon: Icon(Icons.replay),
              )
            ],
          ),
        ),
      );
  Scaffold HomePageLoading() => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );

  Scaffold HomeScaffold(List<UserData>? _data) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOC'),
        actions: [
          IconButton(
            onPressed: () {
              GetStorage().erase();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ),
              );
            },
            icon: Icon(Icons.logo_dev),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final data = _data?[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data?.avatar ?? 'default'),
              ),
              subtitle: Text(data?.email ?? '-'),
              title: Text(data?.firstName ?? '-'),
            );
          },
          itemCount: _data?.length ?? 0,
        ),
      ),
    );
  }
}
