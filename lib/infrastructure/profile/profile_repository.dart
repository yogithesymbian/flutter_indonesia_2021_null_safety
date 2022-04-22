import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_indonesia_2021/domain/core/user/model/user_response.dart';

class ProfileRepository {
  Dio _dio = Dio();

  Future<Either<String, UserResponse>> getAllUserData() async {
    Response _response;
    try {
      _response = await _dio.get(
        "https://reqres.in/api/users?page=2",
      );
      UserResponse _userResponse = UserResponse.fromJson(
        _response.data,
      );
      return right(_userResponse);
    } on DioError catch (e) {
      print(e.response?.statusCode);
      String errorMessage = e.response.toString();
      return left(errorMessage);
    }
  }
}
