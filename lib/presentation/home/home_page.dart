import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_indonesia_2021/application/profile/bloc/profileb_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          return Scaffold(
            appBar: AppBar(
              title: Text('BLOC'),
            ),
            body: Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text('');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
