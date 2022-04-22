import 'package:flutter/material.dart';
import 'package:flutter_indonesia_2021/presentation/app_widget.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(AppWidget());
}
