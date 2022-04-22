import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_indonesia_2021/domain/auth/model/login_request.dart';
import 'package:flutter_indonesia_2021/domain/auth/model/login_response.dart';

class AuthRepository {
  Dio _dio = Dio();

  Future<Either<String, LoginResponse>> signUserWithEmailAndPassword({
    required LoginRequest loginRequest,
  }) async {
    Response _response;
    try {
      _response = await _dio.post(
        "https://reqres.in/api/login",
        data: loginRequest.toJson(),
      );
      LoginResponse _loginResponse = LoginResponse.fromJson(
        _response.data,
      );
      return right(_loginResponse);
    } on DioError catch (e) {
      print(e.response?.statusCode);
      String errorMessage = e.response.toString();
      return left(errorMessage);
    }
  }
}
