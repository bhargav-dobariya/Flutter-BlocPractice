import 'package:bloc/bloc.dart';
import 'package:flutter_login_task/networking/api_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  void login(String phoneNumber, String password) async {
    emit(AuthLoadingState());
    await ApiService().userLogin(mobile: phoneNumber, password: password).then(
      (res) {
        if (res!.statusCode == 200) {
          emit(AuthLoginSuccess());
        } else {
          emit(AuthErrorState(res.statusMessage));
        }
      },
    );
  }
}
