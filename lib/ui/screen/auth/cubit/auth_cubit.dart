import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/repositories/auth_repository.dart';
import 'package:movie/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  void login(String username, String password) async {
    emit(AuthLoading());
    try {
      final user = await repository.login(username, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('is_login', true);
      prefs.setString('name', user.firstName);
      prefs.setString('username', user.username);
      emit(AuthLoaded(user: user));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }
}
