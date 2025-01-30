import 'package:dio/dio.dart';
import 'package:movie/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio dio = Dio();
  final String loginUrl = 'https://dummyjson.com/auth/login';

  Future<UserEntity> login(String username, String password) async {
    final response = await dio.post(
      loginUrl,
      data: {
        'username': username,
        'password': password,
      },
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    final user = UserEntity.fromJson(response.data);

    // Save access token to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', user.accessToken);

    return user;
  }
}
