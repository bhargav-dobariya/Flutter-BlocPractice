part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthErrorState extends AuthState {
  String? errorMessage;
  AuthErrorState(this.errorMessage);
}
